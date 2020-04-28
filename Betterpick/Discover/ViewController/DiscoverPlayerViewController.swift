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

    var playerFilterData: PlayerFilterData {
        didSet {
            // Fetch every time we change the filter data
            startInitialFetching()
        }
    }

    init() {
        self.playerFilterData = PlayerFilterData.default()
    }

    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<GetPlayersResponseBody>) {
        apiManager.players(filterData: playerFilterData, completion: completion)
    }

    override func responseBodyToModel(_ responseBody: GetPlayersResponseBody) -> [PlayerPreview]? {
        return responseBody.players
    }
}

class DiscoverPlayerViewController: UIViewController {

    // MARK: - Properties
    let viewModel: DiscoverPlayerViewModel
    weak var playerSelectingCoordinator: PlayerSelecting?

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
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primary

        setupSubviews()
    }

    // MARK: - Private
    private func setupSubviews() {
        view.add(subview: tableView)
        tableView.embed(in: view)
    }

}

extension DiscoverPlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        guard let teams = viewModel.currentLeague?.teams else { return }
//        coordinator?.select(team: teams[indexPath.row])
    }
}

extension DiscoverPlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.numberOfTeams()
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let teams = viewModel.currentLeague?.teams, let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.reuseIdentifier, for: indexPath) as? TeamTableViewCell else {
//            return UITableViewCell()
//        }
//        let team = teams[indexPath.row]
//        cell.configure(from: team)
//        return cell
        return UITableViewCell()
    }
}
