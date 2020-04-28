//
//  DiscoverViewController.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol NavigationBarProviding {
    func hideNavigationBar()
    func showNavigationBar()
}

extension NavigationBarProviding where Self: UINavigationController {
    func hideNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.barTintColor = .clear
        }
        navigationBar.isTranslucent = true
    }

    func showNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .background
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationBar.shadowImage = nil
            navigationBar.barTintColor = .background
        }
        navigationBar.isTranslucent = false
    }
}

protocol NavigationBarDisplaying {}

extension NavigationBarDisplaying where Self: UIViewController {
    func hideNavigationBar() {
        guard let navigationController = navigationController as? NavigationBarProviding else { return }
        navigationController.hideNavigationBar()
    }

    func showNavigationBar() {
        guard let navigationController = navigationController as? NavigationBarProviding else { return }
        navigationController.showNavigationBar()
    }

    func hideBackBarButtonText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

class DiscoverViewController: UIViewController, NavigationBarDisplaying, Reselectable {

    // MARK: - Properties
    let viewModel: DiscoverViewModel

    // MARK: UI Elements
    let titleLabel = UILabel(style: .largeTitle)

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // Insert the sections
        for (index, section) in viewModel.sections.enumerated() {
            segmentedControl.insertSegment(withTitle: section.sectionTitle, at: index, animated: false)
        }
        if #available(iOS 13.0, *) {} else {
            // Tint color defaults to blue on iOS 12, so set it to black
            segmentedControl.tintColor = .black
        }
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: Size.Font.action)], for: .normal)
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
        return segmentedControl
    }()

    lazy var searchButton: ActionButton = {
        let searchButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "search"))
        searchButton.addTarget(self, action: #selector(didPressSearchButton), for: .touchUpInside)
        return searchButton
    }()

    /// Container view used for the viewcontrollers (sections) controlled by `segmentedControl`
    let sectionContainerView = UIView()

    // MARK: Actions
    var onSearchAction: (() -> Void)?
    var onChangeSectionAction: ((DiscoverSection) -> Void)?

    // MARK: - Initialization
    init(viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = DiscoverViewModel()
        super.init(coder: coder)
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Removes Back button from the next viewcontroller
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.largeTitleDisplayMode = .never

        // View Setup
        view.backgroundColor = .background
        titleLabel.text = "Discover"

        // Subview Setup
        setupSubviews()

        // ViewModel setup
        viewModel.onViewModelUpdate = { [unowned self] section in
            self.updateAppearance()
            self.onChangeSectionAction?(section)
        }
        updateAppearance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    // MARK: - Private
    private func setupSubviews() {
        // Title Label
        view.add(subview: titleLabel)
        titleLabel.embedSidesInMargins(in: view)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        // SegmentedControl
        view.add(subview: segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Size.standardMargin).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        // Search Button
        view.add(subview: searchButton)
        searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: Size.iconSize).isActive = true
        searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor).isActive = true

        // Section Container
        view.add(subview: sectionContainerView)
        sectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sectionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sectionContainerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Size.standardMargin).isActive = true

        // Top Separator
        let separator = HairlineView()
        view.add(subview: separator)
        separator.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: sectionContainerView.topAnchor).isActive = true
    }

    private func updateAppearance() {
        segmentedControl.selectedSegmentIndex = viewModel.currentSection.rawValue
    }

    // MARK: Event Handling
    @objc private func didPressSearchButton() {
        onSearchAction?()
    }

    @objc private func didChangeSegmentedControlValue(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        viewModel.update(section: selectedIndex)
    }
}
