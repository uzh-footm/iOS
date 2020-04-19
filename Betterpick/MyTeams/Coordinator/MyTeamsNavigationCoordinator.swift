//
//  MyTeamsNavigationCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class MyTeamsNavigationCoordinator: NavigationCoordinator, TabbedCoordinator {

    // MARK: - Properties
    let myTeamsCoordinator: MyTeamsCoordinator
    let myTeamsViewController = MyTeamsViewController()

    // MARK: TabbedCoordinator
    var viewController: UIViewController {
        return navigationController
    }

    // MARK: - Initialization
    init(navigationController: UINavigationController = UINavigationController()) {
        self.myTeamsCoordinator = MyTeamsCoordinator(myTeamsViewController: myTeamsViewController)
        super.init(navigationController: navigationController, rootChildCoordinator: myTeamsCoordinator)
    }
}
