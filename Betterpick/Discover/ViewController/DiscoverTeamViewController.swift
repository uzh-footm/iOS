//
//  DiscoverTeamViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// Displays a list of teams from a given League / Nationality
class DiscoverTeamViewController: UIViewController, EmptyStatePresenting {

    // MARK: - Properties
    let viewModel: DiscoverTeamViewModel
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

    let competitionLabelSeparator: HairlineView = {
        let sep = HairlineView()
        sep.alpha = 0
        return sep
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Size.Image.teamLogo + Size.Cell.narrowVerticalMargin * 2
        tableView.removeLastSeparatorAndDontShowEmptyCells()
        tableView.backgroundColor = .background
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: Animation
    lazy var separatorAnimator: DiscoverTeamSeparatorAnimator = {
        let animator = DiscoverTeamSeparatorAnimator()
        animator.separator = self.competitionLabelSeparator
        return animator
    }()

    // MARK: EmptyStatePresenting
    typealias EmptyStateView = FetchingView
    var emptyStateView: FetchingView?
    var emptyStateSuperview: UIView {
        // If the viewModel already loaded the leagues, use the tableview as the superview for the spinner, otherwise use the entire view to also hide the league pickerview
        return viewModel.isDisplayingLeagues ? tableView : view
    }

    // MARK: - Initialization
    init(viewModel: DiscoverTeamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = DiscoverTeamViewModel()
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

        // League Info Label and TableView separator
        view.add(subview: competitionLabelSeparator)
        competitionLabelSeparator.embedSides(in: view)
        competitionLabelSeparator.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
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
        case .displaying(_, .fetching(let league)):
            addEmptyState()
            updateLabel(league: league)
        case .displaying(_, .displaying(let league)):
            removeEmptyState()
            tableView.reloadData()
            view.layoutIfNeeded()
            tableView.setContentOffset(.zero, animated: false)
            updateLabel(league: league)
        default:
            addEmptyState()
        }
    }
}
