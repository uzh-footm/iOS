//
//  DiscoverCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverCoordinator: ChildCoordinator {

    // MARK: - Properties
    let discoverViewController: DiscoverViewController
    // MARK: ChildCoordinator
    var viewController: UIViewController { return discoverViewController }

    // MARK: - Initialization
    init(discoverViewController: DiscoverViewController) {
        self.discoverViewController = discoverViewController
    }

    // MARK: - Lifecycle
    func start() {

    }
}
