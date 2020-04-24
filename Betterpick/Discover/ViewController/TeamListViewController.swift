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

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dontShowEmptyCells()
        tableView.separatorInset = .zero
        tableView.backgroundColor = .background
        tableView.register(TeamListTableViewCell.self, forCellReuseIdentifier: TeamListTableViewCell.reuseIdentifier)
        return tableView
    }()

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
        separator.backgroundColor = tableView.separatorColor
        view.add(subview: separator)
        separator.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true

        // League Info Label
        view.add(subview: competitionInfoLabel)
        competitionInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let labelLeading = competitionInfoLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor, constant: Size.standardMargin)
        labelLeading.priority = UILayoutPriority.init(rawValue: 999)
        labelLeading.isActive = true
        let labelTrailing = competitionInfoLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor, constant: Size.standardMargin)
        labelTrailing.priority = UILayoutPriority.init(rawValue: 999)
        labelTrailing.isActive = true
        competitionInfoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Size.standardMargin).isActive = true

        // Table view
        view.add(subview: tableView)
        tableView.topAnchor.constraint(equalTo: competitionInfoLabel.bottomAnchor, constant: Size.standardMargin).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func updateUI() {
        let hypertext = "Bundesliga"
        competitionInfoLabel.set(hypertext: hypertext, in: "Showing teams from \(hypertext)")
    }
}

// MARK: - UITableViewDataSource
extension TeamListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.collection.count
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.reuseIdentifier, for: indexPath) as? ServiceTableViewCell else {
//            return UITableViewCell()
//        }
//        let service = viewModel.collection[indexPath.row]
//        cell.configure(from: service)
//        return cell
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension TeamListViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if tableView.refreshControl?.isRefreshing ?? false {
//            viewModel.fetchUserServices()
//        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let service = viewModel.collection[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
//        delegate?.didSelect(service: service)
    }
}
