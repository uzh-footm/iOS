//
//  TeamListViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// Displays a list of teams from a given League / Nationality
class TeamListViewController: UIViewController, EmptyStatePresenting {

    // MARK: - Properties
    let viewModel: TeamListViewModel
    weak var coordinator: TeamSelecting?

    // MARK: UI Elements
    /// Displays information about the competition that is displayed by the tableview
    lazy var competitionInfoLabel: TappableResponderLabel = {
        let label = TappableResponderLabel()
        label.set(style: .primary)
        label.delegate = self
        return label
    }()

    lazy var competitionPickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.toolbarDelegate = self
        return picker
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.removeLastSeparatorAndDontShowEmptyCells()
        //tableView.separatorInset = .zero
        tableView.backgroundColor = .background
        tableView.register(TeamListTableViewCell.self, forCellReuseIdentifier: TeamListTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: EmptyStatePresenting
    typealias EmptyStateView = FetchingView
    var emptyStateView: FetchingView?
    var emptyStateSuperview: UIView {
        // If the viewModel already loaded the leagues, use the tableview as the superview for the spinner, otherwise use the entire view to also hide the league pickerview
        return viewModel.isDisplayingLeagues ? tableView : view
    }

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

        // Label
        competitionInfoLabel.onHypertextTapped = { [unowned self] in
            self.competitionInfoLabel.becomeFirstResponder()
        }

        updateViewStateAppearance()

        // ViewModel setup
        viewModel.onStateUpdate = {
            self.updateViewStateAppearance()
        }
        viewModel.startFetchingAfterInitial()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        competitionInfoLabel.resignFirstResponder()
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

    private func updateLabel(hypertext: String) {
        competitionInfoLabel.set(hypertext: hypertext, in: "Showing teams from \(hypertext)")
    }

    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .displaying(_, .fetching(let league)):
            addEmptyState()
            updateLabel(hypertext: league.name)
        case .displaying(_, .displaying(let league)):
            removeEmptyState()
            tableView.reloadData()
            updateLabel(hypertext: league.name)
        default:
            addEmptyState()
        }
    }
}

// MARK: - UITableViewDataSource
extension TeamListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTeams()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let teams = viewModel.currentLeague?.teams, let cell = tableView.dequeueReusableCell(withIdentifier: TeamListTableViewCell.reuseIdentifier, for: indexPath) as? TeamListTableViewCell else {
            return UITableViewCell()
        }
        let team = teams[indexPath.row]
        cell.configure(from: team)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let teams = viewModel.currentLeague?.teams else { return }
        coordinator?.select(team: teams[indexPath.row])
    }
}

// MARK: - UIPickerViewDelegate
extension TeamListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.league(at: row)?.name
    }
}

// MARK: - UIPickerViewDataSource
extension TeamListViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfLeagues()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension TeamListViewController: ToolbarPickerViewDelegate {
    func didTapDone() {
        let row = competitionPickerView.selectedRow(inComponent: 0)
        viewModel.fetchLeague(at: row)
        competitionInfoLabel.resignFirstResponder()
    }

    func didTapCancel() {
        competitionInfoLabel.resignFirstResponder()
    }
}

extension TeamListViewController: TappableResponderLabelDelegate {
    var responderInputView: UIView {
        return competitionPickerView
    }

    var responderAccessoryView: UIView? {
        return competitionPickerView.toolbar
    }
}
