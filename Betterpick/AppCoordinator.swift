// AppCoordinator.swift
// Betterpick
//
// Created by David Bielik on 13/04/2020.
//Copyright © 2020 dvdblk. All rights reserved.
//

class AppCoordinator {

    // MARK: - Properties
    let viewController: RootViewController

    // MARK: - Initialization
    init(with viewController: RootViewController) {
        self.viewController = viewController
    }
}

// MARK: - Coordinator
extension AppCoordinator: Coordinator {
    func start() {
        #warning("Incomplete implementation.")
    }
}
