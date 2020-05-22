//
//  DiscoverTeamViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// Displays a list of teams from a given League / Nationality
class DiscoverTeamViewController: DiscoverChildBaseViewController<DiscoverTeamViewModel>, FetchingStatePresenting, TableViewReselectable {

    // MARK: - Properties
    weak var coordinator: TeamSelecting?

    // MARK: UI Elements
    /// Displays information about the competition that is displayed by the tableview
    lazy var competitionInfoLabel: TappablePickerResponderLabel = {
        let label = TappablePickerResponderLabel()
        label.set(style: .secondary)
        label.delegate = self
        return label
    }()

    lazy var competitionPickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.toolbarDelegate = self
        picker.title = "Competitions"
        return picker
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()

        // Label
        competitionInfoLabel.onHypertextTapped = { [unowned self] in
            self.competitionInfoLabel.becomeFirstResponder()
        }

        updateViewStateAppearance()

        // ViewModel setup
        viewModel.onStateUpdate = {
            self.updateViewStateAppearance()
        }
        viewModel.start()
    }

    // MARK: Pickerview
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        competitionInfoLabel.resignFirstResponder()
    }

    // MARK: - Private
    private func tableViewSetup() {
        tableView.dataSource = self
        tableView.register(reusableCell: TeamTableViewCell.self)
    }

    final override func setup(discoverHeaderView headerView: UIView) {
        headerView.add(subview: competitionInfoLabel)
        competitionInfoLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        let labelLeading = competitionInfoLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor, constant: Size.standardMargin)
        labelLeading.priority = UILayoutPriority.init(rawValue: 999)
        labelLeading.isActive = true
        let labelTrailing = competitionInfoLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor, constant: Size.standardMargin)
        labelTrailing.priority = UILayoutPriority.init(rawValue: 999)
        labelTrailing.isActive = true
        competitionInfoLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    }

    private func updateLabel(league: League) {
        let hypertext = league.name
        let prefix: String
        if let numTeams = league.teams?.count {
            prefix = "Showing \(numTeams) teams"
        } else {
            prefix = "Showing teams"
        }
        competitionInfoLabel.set(hypertext: hypertext, in: "\(prefix) from \(hypertext)")
    }

    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .fetching:
            if let selectedLeague = viewModel.selectedLeague {
                updateLabel(league: selectedLeague)
            }
            addFetchingStateView()
        case .displaying:
            tableView.setContentOffset(.zero, animated: false)
            tableView.reloadData()
            removeFetchingStateView()
        case .error(let error):
            addFetchingStateView()
            showErrorState(error: error)
        }
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let teams = viewModel.currentLeague?.teams else { return }
        coordinator?.select(team: teams[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Size.Cell.teamHeight
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
