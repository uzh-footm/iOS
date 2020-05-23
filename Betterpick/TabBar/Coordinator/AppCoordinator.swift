// AppCoordinator.swift
// Betterpick
//
// Created by David Bielik on 13/04/2020.
//Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Properties
    // MARK: UI
    let window: UIWindow
    let rootViewController: RootViewController
    // MARK: Coordinators
    var tabBarCoordinator: TabBarCoordinator?

    // MARK: - Initialization
    init(with window: UIWindow) {
        self.window = window
        // Initialize the RootViewController
        let rootVM = RootViewModel()
        rootViewController = RootViewController(viewModel: rootVM)
    }

    // MARK: - Coordinator
    /// Start the application coordinator
    func start() {
        rootViewController.onDataLoaded = startTabBarFlow
        // start the app window
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    // MARK: - Actions
    func startTabBarFlow(model: LeagueAndNationalityData) {
        // Initialize TabBarViewController
        let tabBarVM = TabBarViewModel(data: model)
        let tabBarViewController = TabBarViewController(viewModel: tabBarVM)
        let tabBarCoordinator = TabBarCoordinator(tabBarViewController: tabBarViewController)
        tabBarCoordinator.start()
        self.tabBarCoordinator = tabBarCoordinator
        // Add the TabBarVC to the viewHierarchy
        rootViewController.add(childViewController: tabBarCoordinator.tabBarViewController)
    }
}
