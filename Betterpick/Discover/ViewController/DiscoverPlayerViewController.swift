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

    // MARK: Actions
    var onFilterAction: (() -> Void)?

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateSuperview: UIView { return view }
    var fetchingStateView: FetchingView?

    // MARK: UI
    let playerFilterDataInformationLabel = UILabel(style: .secondary)

    lazy var playerFilterActionButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "filter_slider"), target: self, action: #selector(didPressPlayerFilterActionButton))

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

        setupSubviews()

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance
        viewModel.onPlayerFilterDataUpdated = updateAppearance
        viewModel.start()

        updateViewStateAppearance()
        updateAppearance()
    }

    // MARK: - Private
    private func setupSubviews() {
        // Label
        view.add(subview: playerFilterDataInformationLabel)
        playerFilterDataInformationLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        playerFilterDataInformationLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Size.standardMargin).isActive = true

        // Button
        view.add(subview: playerFilterActionButton)
        playerFilterActionButton.centerYAnchor.constraint(equalTo: playerFilterDataInformationLabel.centerYAnchor).isActive = true
        playerFilterActionButton.heightAnchor.constraint(equalToConstant: Size.iconSize).isActive = true
        playerFilterActionButton.widthAnchor.constraint(equalTo: playerFilterActionButton.heightAnchor).isActive = true
        playerFilterActionButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        // Label + Button
        playerFilterDataInformationLabel.trailingAnchor.constraint(equalTo: playerFilterActionButton.leadingAnchor).isActive = true

        // Table view
        view.add(subview: tableView)
        tableView.embedSides(in: view)
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: playerFilterDataInformationLabel.bottomAnchor, constant: Size.standardMargin).isActive = true
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
