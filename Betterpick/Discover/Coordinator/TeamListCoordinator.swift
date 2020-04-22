//
//  TeamListCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TeamListCoordinator: SectionedCoordinator {

    // MARK: - Properties
    let teamListViewController: TeamListViewController

    var viewController: UIViewController { return teamListViewController }

    // MARK: - Initialization
    init(teamListViewController: TeamListViewController) {
        self.teamListViewController = teamListViewController
    }

    // MARK: - Lifecycle
    func start() {

    }
}
