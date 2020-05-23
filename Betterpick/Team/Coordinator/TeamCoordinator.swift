//
//  TeamCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TeamCoordinator: ChildCoordinator {

    // MARK: - Properties
    let teamViewController: TeamViewController

    // MARK: ChildCoordinator
    var viewController: UIViewController {
        return teamViewController
    }

    // MARK: - Initialization
    init(viewController: TeamViewController) {
        self.teamViewController = viewController
    }

    func start() {

    }
}
