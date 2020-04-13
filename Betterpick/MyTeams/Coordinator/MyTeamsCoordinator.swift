//
//  MyTeamsCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class MyTeamsCoordinator: TabbedCoordinator {

    // MARK: - Properties
    let myTeamsViewController: UIViewController

    // TabbedCoordinator implemenation
    var viewController: UIViewController {
        return myTeamsViewController
    }

    // MARK: - Initialization
    init(myTeamsViewController: MyTeamsViewController) {
        self.myTeamsViewController = myTeamsViewController
    }

    func start() {}
}
