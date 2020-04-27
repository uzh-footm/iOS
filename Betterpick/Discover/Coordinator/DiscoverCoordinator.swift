//
//  DiscoverCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverCoordinator: SectioningCoordinator, ChildCoordinator {

    typealias SectionDefiningEnum = DiscoverSection

    // MARK: - Properties
    let discoverViewController: DiscoverViewController
    var searchCoordinator: SearchCoordinator?
    // MARK: SectioningCoordinator
    var activeCoordinator: SectionedCoordinator?
    var childCoordinators: [DiscoverSection: SectionedCoordinator] = [:]
    // MARK: PlayerSelecting & TeamSelecting
    weak var teamAndPlayerSelectingCoordinator: (PlayerSelecting & TeamSelecting)?

    // MARK: ChildCoordinator
    var containerViewController: UIViewController & ChildViewControllerContainerProviding {
        return discoverViewController
    }

    // MARK: - Initialization
    init(discoverViewController: DiscoverViewController) {
        self.discoverViewController = discoverViewController
    }

    // MARK: - Lifecycle
    func start() {
        discoverViewController.onSearchAction = startSearchFlow
        discoverViewController.onChangeSectionAction = changeSection
        let initialSection = discoverViewController.viewModel.currentSection
        changeSection(to: initialSection)
    }

    func createChildCoordinatorFrom(section: DiscoverSection) -> SectionedCoordinator {
        switch section {
        case .players:
            let playerListVC = PlayerListViewController()
            let playerListCoordinator = PlayerListCoordinator(playerListViewController: playerListVC)
            playerListVC.playerSelectingCoordinator = teamAndPlayerSelectingCoordinator
            return playerListCoordinator
        case .teams:
            let teamListVM = TeamListViewModel()
            let teamListVC = TeamListViewController(viewModel: teamListVM)
            teamListVC.coordinator = teamAndPlayerSelectingCoordinator
            return TeamListCoordinator(teamListViewController: teamListVC)
        }
    }

    // MARK: - Action Handlers
    // MARK: Search
    func startSearchFlow() {
        // Guard that we are not doing another search right now
        guard searchCoordinator == nil else { return }
        // Create a new SearchViewController and its Coordinator
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.onFinishedSearching = { [unowned self] in
            self.finishSearchFlow()
        }
        searchCoordinator = SearchCoordinator(searchViewController: searchVC)
        discoverViewController.present(searchVC, animated: false, completion: nil)
    }

    func finishSearchFlow() {
        // Guard that some search coordinator is active
        guard let activeSearchCoordinator = searchCoordinator else { return }
        activeSearchCoordinator.searchViewController.dismiss(animated: false, completion: nil)
        searchCoordinator = nil
    }
}
