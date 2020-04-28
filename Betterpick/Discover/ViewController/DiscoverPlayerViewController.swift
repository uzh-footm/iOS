//
//  DiscoverPlayerViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

struct PlayerFilterData: Encodable {

    enum SortBy: String, Encodable {
        case asc
        case desc
    }

    var sortBy: SortBy

    static func `default`() -> PlayerFilterData {
        return PlayerFilterData(sortBy: .asc)
    }
}

class DiscoverPlayerViewModel: FetchingViewModel<GetPlayersResponseBody, [PlayerPreview]> {

    // MARK: - Properties
    var playerFilterData: PlayerFilterData {
        didSet {
            // Fetch every time we change the filter data
            startInitialFetching()
        }
    }

    // MARK: - Initialization
    init() {
        self.playerFilterData = PlayerFilterData.default()
    }

    // MARK: - Inherited
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<GetPlayersResponseBody>) {
        apiManager.players(filterData: playerFilterData, completion: completion)
    }

    override func responseBodyToModel(_ responseBody: GetPlayersResponseBody) -> [PlayerPreview]? {
        return responseBody.players
    }

    // MARK: - Public
    public func numberOfPlayers() -> Int {
        guard case .displaying(let players) = state else { return 0 }
        return players.count
    }

    public func player(at row: Int) -> PlayerPreview? {
        guard case .displaying(let players) = state else { return nil }
        return players[row]
    }
}

class DiscoverPlayerViewController: UIViewController, EmptyStatePresenting {

    // MARK: - Properties
    let viewModel: DiscoverPlayerViewModel
    weak var playerSelectingCoordinator: PlayerSelecting?

    // MARK: EmptyStatePresenting
    typealias EmptyStateView = FetchingView
    var emptyStateSuperview: UIView { return view }
    var emptyStateView: FetchingView?

    // MARK: - Initialization
    init(viewModel: DiscoverPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

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
        viewModel.startInitialFetching()

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
            addEmptyState()
        case .displaying:
            removeEmptyState()
            tableView.reloadData()
        default:
            addEmptyState()
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
