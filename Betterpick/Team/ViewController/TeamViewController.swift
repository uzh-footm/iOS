//
//  TeamViewController.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, NavigationBarDisplaying {

    // MARK: - Properties
    let viewModel: TeamViewModel

    // MARK: - Initialization
    init(viewModel: TeamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primary

        setupSubviews()
        showNavigationBar()
        hideBackBarButtonText()

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func setupSubviews() {

    }

    private func updateViewStateAppearance() {
        title = viewModel.team.name
    }
}
