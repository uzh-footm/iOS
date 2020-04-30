//
//  DiscoverViewController.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverViewController: VMViewController<DiscoverViewModel>, NavigationBarDisplaying, Reselectable, FetchingStatePresenting {

    // MARK: - Properties
    // MARK: UI Elements
    let titleLabel = UILabel(style: .largeTitle)

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateSuperview: UIView { return view }
    var fetchingStateView: FetchingView?

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

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Removes Back button from the next viewcontroller
        hideBackBarButtonText()
        navigationItem.largeTitleDisplayMode = .never

        // View Setup
        view.backgroundColor = .background
        titleLabel.text = viewModel.title

        // Subview Setup
        setupSubviews()

        // ViewModel setup
        viewModel.onSectionUpdate = { [unowned self] section in
            self.updateAppearance()
            // Notify coordinator
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
