//
//  PlayerFilterCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerFilterCoordinator: ChildCoordinator {

    // MARK: - Properties
    let playerFilterViewController: PlayerFilterViewController
    let navigationController = PlayerFilterNavigationController()

    // MARK: ChildCoordinator
    var viewController: UIViewController { return navigationController }

    init(playerFilterViewController: PlayerFilterViewController) {
        self.playerFilterViewController = playerFilterViewController
    }

    func start() {
        navigationController.setViewControllers([playerFilterViewController], animated: false)
    }
}
