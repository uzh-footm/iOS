//
//  DiscoverPlayerViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverPlayerViewController: DiscoverChildBaseViewController<DiscoverPlayerViewModel>, FetchingStatePresenting, TableViewReselectable {

    // MARK: - Properties
    weak var playerSelectingCoordinator: PlayerSelecting?

    // MARK: Actions
    var onFilterAction: (() -> Void)?

    // MARK: UI
    let playerFilterDataInformationLabel = UILabel(style: .secondary)

    lazy var playerFilterActionButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "filter_slider"), target: self, action: #selector(didPressPlayerFilterActionButton))

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance
        viewModel.onPlayerFilterDataUpdated = updateAppearance
        viewModel.start()

        updateViewStateAppearance()
        updateAppearance()
    }

    // MARK: - Private
    private func setupTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = Size.Image.teamLogo + Size.Cell.narrowVerticalMargin * 2
        tableView.register(PlayerPreviewTableViewCell.self, forCellReuseIdentifier: PlayerPreviewTableViewCell.reuseIdentifier)
    }

    final override func setup(discoverHeaderView headerView: UIView) {
        // Label
        headerView.add(subview: playerFilterDataInformationLabel)
        playerFilterDataInformationLabel.leadingAnchor.constraint(equalTo: headerView.layoutMarginsGuide.leadingAnchor).isActive = true
        playerFilterDataInformationLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        // Button
        view.add(subview: playerFilterActionButton)
        playerFilterActionButton.centerYAnchor.constraint(equalTo: playerFilterDataInformationLabel.centerYAnchor).isActive = true
        playerFilterActionButton.heightAnchor.constraint(equalToConstant: Size.iconSize).isActive = true
        playerFilterActionButton.widthAnchor.constraint(equalTo: playerFilterActionButton.heightAnchor).isActive = true
        playerFilterActionButton.trailingAnchor.constraint(equalTo: headerView.layoutMarginsGuide.trailingAnchor).isActive = true

        // Label + Button
        playerFilterDataInformationLabel.trailingAnchor.constraint(equalTo: playerFilterActionButton.leadingAnchor).isActive = true
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

    private func updateAppearance() {
        playerFilterDataInformationLabel.text = viewModel.playerFilterData.description
    }

    // MARK: Event Handlers
    @objc private func didPressPlayerFilterActionButton() {
        onFilterAction?()
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
