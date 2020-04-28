//
//  TeamViewController.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit
import Combine

class TeamViewController: UIViewController, NavigationBarDisplaying, EmptyStatePresenting {

    // MARK: - Properties
    let viewModel: TeamViewModel
    weak var playerSelectingCoordinator: PlayerSelecting?

    // MARK: EmptyStatePresenting
    typealias EmptyStateView = FetchingView
    var emptyStateView: FetchingView?
    var emptyStateSuperview: UIView { return tableView }

    // MARK: UI
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .background
        table.register(PlayerPreviewTableViewCell.self, forCellReuseIdentifier: PlayerPreviewTableViewCell.reuseIdentifier)
        return table
    }()

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
        viewModel.startInitialFetching()

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func setupSubviews() {
        view.add(subview: tableView)
        tableView.embed(in: view)
    }

    private func updateViewStateAppearance() {
        title = viewModel.team.name

        switch viewModel.state {
        case .fetching:
            addEmptyState()
        case .displaying:
            removeEmptyState()
            tableView.reloadData()
        default:
            addEmptyState()
        }
    }
}

// MARK: - UITableViewDelegate
extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let playerPreview = viewModel.player(at: indexPath) else { return }
        playerSelectingCoordinator?.select(player: playerPreview)
    }
}

// MARK: - UITableViewDataSource
extension TeamViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let squad = viewModel.getSquad() else { return 0 }
        return squad.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPlayersForPosition(at: section)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForPosition(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let player = viewModel.player(at: indexPath), let cell = tableView.dequeueReusableCell(withIdentifier: PlayerPreviewTableViewCell.reuseIdentifier, for: indexPath) as? PlayerPreviewTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(from: player)
        return cell
    }
}
