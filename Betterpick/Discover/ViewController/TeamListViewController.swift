//
//  TeamListViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// Displays a list of teams from a given League / Nationality
class TeamListViewController: UIViewController {

    // MARK: - Properties
    let viewModel: TeamListViewModel

    // MARK: UI Elements
    /// Displays information about the competition that is displayed by the tableview
    let competitionInfoLabel = TappableLabel(fontSize: Size.Font.default)

    let tableView = UITableView()

    // MARK: - Initialization
    init(viewModel: TeamListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = TeamListViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()

        updateUI()
    }

    // MARK: - Private
    private func setupSubviews() {
        // Separator
        let separator = HairlineView()
        view.add(subview: separator)
        separator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true

        // League Info Label
        view.add(subview: competitionInfoLabel)
        competitionInfoLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: Size.standardMargin).isActive = true
        competitionInfoLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        competitionInfoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Size.standardMargin).isActive = true
    }

    private func updateUI() {
        let hypertext = "Bundesliga"
        competitionInfoLabel.set(hypertext: hypertext, in: "Showing teams from \(hypertext)")
    }
}
