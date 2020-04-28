//
//  DiscoverPlayerCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverPlayerCoordinator: SectionedCoordinator {
    var viewController: UIViewController {
        return discoverPlayerViewController
    }

    let discoverPlayerViewController: DiscoverPlayerViewController

    init(discoverPlayerViewController: DiscoverPlayerViewController) {
        self.discoverPlayerViewController = discoverPlayerViewController
    }

    func start() {

    }
}
