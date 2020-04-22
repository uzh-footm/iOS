//
//  PlayerListCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerListCoordinator: SectionedCoordinator {
    var viewController: UIViewController {
        return playerListViewController
    }

    let playerListViewController: PlayerListViewController

    init(playerListViewController: PlayerListViewController) {
        self.playerListViewController = playerListViewController
    }

    func start() {

    }
}
