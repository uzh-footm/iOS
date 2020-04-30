//
//  PlayerFilterCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerFilterCoordinator: ChildCoordinator {
    let playerFilterViewController: PlayerFilterViewController

    var viewController: UIViewController { return playerFilterViewController }

    init(playerFilterViewController: PlayerFilterViewController) {
        self.playerFilterViewController = playerFilterViewController
    }

    func start() {}
}
