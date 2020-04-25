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
    let rootViewController = RootViewController()
    // MARK: Coordinators
    var tabBarCoordinator: TabBarCoordinator!

    // MARK: - Initialization
    init(with window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordinator
    /// Start the application coordinator
    func start() {
        // start the app window
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        // Create the TabBarViewController
        let tabBarViewController = TabBarViewController(viewModel: TabBarViewModel())
        let tabBarCoordinator = TabBarCoordinator(tabBarViewController: tabBarViewController)
        tabBarCoordinator.start()
        self.tabBarCoordinator = tabBarCoordinator

        // Add it to the VC hierarchy
        rootViewController.add(childViewController: tabBarViewController)
    }
}
