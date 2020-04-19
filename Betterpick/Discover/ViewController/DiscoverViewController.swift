//
//  DiscoverViewController.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    // MARK: - Properties
    let viewModel: DiscoverViewModel

    // MARK: Actions
    var onSearchAction: (() -> Void)?

    // MARK: UI Elements
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // Insert the sections
        for (index, section) in viewModel.sections.enumerated() {
            segmentedControl.insertSegment(withTitle: section.sectionTitle, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = viewModel.currentSection.rawValue
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
        return segmentedControl
    }()

    lazy var searchButton: ActionButton = {
        let searchButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "search"))
        searchButton.addTarget(self, action: #selector(didPressSearchButton), for: .touchUpInside)
        return searchButton
    }()

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

        // View Setup
        view.backgroundColor = .background
        title = "Discover"

        // Subview Setup
        setupSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Enable search button interaction
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Enable navigation bar interaction in other view controllers
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }

    // MARK: - Private
    private func setupSubviews() {
        // SegmentedControl
        view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Size.doubleStandardMargin).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        // Search Button
        view.add(subview: searchButton)
        searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -Size.standardMargin).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: Size.iconSize).isActive = true
        searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor).isActive = true
    }

    // MARK: Event Handling
    @objc private func didPressSearchButton() {
        onSearchAction?()
    }

    @objc private func didChangeSegmentedControlValue() {

    }
}
