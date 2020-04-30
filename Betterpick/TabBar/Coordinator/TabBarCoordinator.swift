//
//  TabBarCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TabBarCoordinator: SectioningCoordinator {
    typealias SectionDefiningEnum = Tab

    var containerViewController: (UIViewController & ChildViewControllerContainerProviding) {
        return tabBarViewController
    }

    let tabBarViewController: TabBarViewController
    var activeCoordinator: TabbedCoordinator?
    var childCoordinators: [Tab: TabbedCoordinator] = [:]

    init(tabBarViewController: TabBarViewController) {
        self.tabBarViewController = tabBarViewController
    }

    // MARK: - Coordinator
    func start() {
        tabBarViewController.delegate = self

        // Set initial tab
        tabBarViewController.viewModel.updateTab(to: .discover)
    }

    // MARK: - SectioningCoordinator
    func createChildCoordinatorFrom(section: Tab) -> SectionedCoordinator {
        let childCoordinator: ChildCoordinator
        switch section {
        case .discover:
            let leagueAndNationality = tabBarViewController.viewModel.leagueAndNationalityData
            childCoordinator = DiscoverNavigationCoordinator(data: leagueAndNationality)
        case .myTeams:
            childCoordinator = MyTeamsNavigationCoordinator()
        case .settings:
            let settingsVC = SettingsViewController()
            childCoordinator = SettingsCoordinator(settingsViewController: settingsVC)
        }
        return childCoordinator
    }
}

// MARK: - TabBarViewControllerDelegate
extension TabBarCoordinator: TabBarViewControllerDelegate {

    func didSelect(tab: Tab) {
        changeSection(to: tab)
    }

    func didReselect(tab: Tab) {
        guard let childCoordinator = childCoordinators[tab] else { return }
        guard let reselectableViewController = childCoordinator.viewController as? Reselectable else { return }
        guard !reselectableViewController.reselect() else { return }
        reselectableViewController.reselectChildViewControllers()
    }
}
