//
//  DiscoverTeamCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverTeamCoordinator: SectionedCoordinator {

    // MARK: - Properties
    let discoverTeamViewController: DiscoverTeamViewController

    var viewController: UIViewController { return discoverTeamViewController }

    // MARK: - Initialization
    init(discoverTeamViewController: DiscoverTeamViewController) {
        self.discoverTeamViewController = discoverTeamViewController
    }

    // MARK: - Lifecycle
    func start() {}
}
