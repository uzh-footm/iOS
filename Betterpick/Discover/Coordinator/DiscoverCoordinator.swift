//
//  DiscoverCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverCoordinator: TabbedCoordinator {

    // MARK: - Properties
    let discoverViewController: UIViewController

    // TabbedCoordinator implemenation
    var viewController: UIViewController {
        return discoverViewController
    }

    // MARK: - Initialization
    init(discoverViewController: DiscoverViewController) {
        self.discoverViewController = discoverViewController
    }

    func start() {    }
}
