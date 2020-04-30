//
//  DiscoverPlayerViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverPlayerViewController: VMViewController<DiscoverPlayerViewModel>, FetchingStatePresenting {

    // MARK: - Properties
    weak var playerSelectingCoordinator: PlayerSelecting?

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateSuperview: UIView { return view }
    var fetchingStateView: FetchingView?

    // MARK: UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Size.Image.teamLogo + Size.Cell.narrowVerticalMargin * 2
        tableView.removeLastSeparatorAndDontShowEmptyCells()
        tableView.backgroundColor = .background
        tableView.register(PlayerPreviewTableViewCell.self, forCellReuseIdentifier: PlayerPreviewTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primary

        setupSubviews()

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance
        viewModel.start()

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func setupSubviews() {
        view.add(subview: tableView)
        tableView.embed(in: view)
    }

    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .fetching:
            addFetchingStateView()
        case .displaying:
            removeFetchingStateView()
            tableView.reloadData()
        default:
            addFetchingStateView()
        }
    }
}

extension DiscoverPlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let player = viewModel.player(at: indexPath.row) else { return }
        playerSelectingCoordinator?.select(player: player)
    }
}

extension DiscoverPlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPlayers()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let player = viewModel.player(at: indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: PlayerPreviewTableViewCell.reuseIdentifier, for: indexPath) as? PlayerPreviewTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(from: player)
        return cell
    }
}
