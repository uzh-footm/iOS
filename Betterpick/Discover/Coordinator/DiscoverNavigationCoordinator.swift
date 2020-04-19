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
    let discoverViewController = DiscoverViewController()

    // MARK: TabbedCoordinator
    var viewController: UIViewController {
        return navigationController
    }

    // MARK: - Initialization
    init(navigationController: UINavigationController = LargeTitleNavigationController()) {
        self.discoverCoordinator = DiscoverCoordinator(discoverViewController: discoverViewController)
        super.init(navigationController: navigationController, rootChildCoordinator: discoverCoordinator)
    }
}
