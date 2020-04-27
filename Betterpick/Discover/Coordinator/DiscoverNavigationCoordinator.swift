//
//  DiscoverNavigationCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverNavigationCoordinator: NavigationCoordinator, TabbedCoordinator {

    // MARK: - Properties
    let discoverCoordinator: DiscoverCoordinator
    let discoverViewController: DiscoverViewController

    // MARK: TabbedCoordinator
    var viewController: UIViewController {
        return navigationController
    }

    // MARK: - Initialization
    init(navigationController: UINavigationController = LargeTitleNavigationController.initWithLargeNavBar()) {
        discoverViewController = DiscoverViewController(viewModel: DiscoverViewModel())
        self.discoverCoordinator = DiscoverCoordinator(discoverViewController: discoverViewController)
        super.init(navigationController: navigationController, rootChildCoordinator: discoverCoordinator)
    }

    override func start() {
        discoverCoordinator.teamAndPlayerSelectingCoordinator = self
        super.start()
    }

    // MARK: - Action Handlers
    // MARK: TeamDetail
    func startTeamDetailFlow(_ team: TeamPreview) {
        // Close the search VC if needed
        discoverCoordinator.finishSearchFlow()
        let teamVM = TeamViewModel(teamPreview: team)
        let teamVC = TeamViewController(viewModel: teamVM)
        teamVC.playerSelectingCoordinator = self
        let teamCoordinator = TeamCoordinator(viewController: teamVC)
        add(childCoordinator: teamCoordinator, push: true)
    }

    // MARK: PlayerDetail
    func startPlayerDetailFlow(_ playerPreview: PlayerPreview) {
        // Close the search VC if needed
        discoverCoordinator.finishSearchFlow()
        let playerDetailVM = PlayerDetailViewModel(playerPreview: playerPreview)
        let playerDetailVC = PlayerDetailViewController(viewModel: playerDetailVM)
        navigationController.pushViewController(playerDetailVC, animated: true)
    }
}

// MARK: - TeamSelecting
extension DiscoverNavigationCoordinator: TeamSelecting {
    func select(team: TeamPreview) {
        startTeamDetailFlow(team)
    }
}

// MARK: - PlayerSelecting
extension DiscoverNavigationCoordinator: PlayerSelecting {
    func select(player: PlayerPreview) {
        startPlayerDetailFlow(player)
    }
}
