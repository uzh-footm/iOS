//
//  TabBarCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {

    let tabBarViewController: TabBarViewController
    var activeCoordinator: TabbedCoordinator?
    var childCoordinators: [Tab: TabbedCoordinator] = [:]

    init(tabBarViewController: TabBarViewController) {
        self.tabBarViewController = tabBarViewController
    }

    // MARK: - Coordinator
    func start() {
        tabBarViewController.delegate = self
        setInitial(tab: .discover)
    }

    // MARK: - Private
    private func setInitial(tab: Tab) {
        tabBarViewController.viewModel.updateTab(to: tab)
    }
}

// MARK: - TabBarViewControllerDelegate
extension TabBarCoordinator: TabBarViewControllerDelegate {

    func didSelect(tab: Tab) {
        let selectedCoordinator: TabbedCoordinator
        if let existingChildCoordinator = childCoordinators[tab] {
            // coordinator instantiated previously
            selectedCoordinator = existingChildCoordinator
        } else {
            // create a new child coordinator in case it's the first time we see it
            let childCoordinator: TabbedCoordinator
            switch tab {
            case .discover:
                childCoordinator = DiscoverNavigationCoordinator()
            case .myTeams:
                let myTeamsVC = MyTeamsViewController()
                childCoordinator = MyTeamsCoordinator(myTeamsViewController: myTeamsVC)
            case .settings:
                let settingsVC = SettingsViewController()
                childCoordinator = SettingsCoordinator(settingsViewController: settingsVC)
            }
            childCoordinators[tab] = childCoordinator
            // and start it...
            childCoordinator.start()
            selectedCoordinator = childCoordinator
        }

        // Remove previously active coordinator's view controller if needed
        if let currentlyActiveCoordinator = activeCoordinator {
            let activeVC = currentlyActiveCoordinator.viewController
            tabBarViewController.remove(childViewController: activeVC)
        }
        // Set new active coordinator
        activeCoordinator = selectedCoordinator
        tabBarViewController.embed(viewController: selectedCoordinator.viewController)
    }

    func didReselect(tab: Tab) {
        guard let childCoordinator = childCoordinators[tab] else { return }
        guard let reselectableViewController = childCoordinator.viewController as? Reselectable else { return }
        reselectableViewController.reselect()
    }
}
