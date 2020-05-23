//
//  SearchCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {

    // MARK: - Properties
    let searchViewController: UIViewController

    // MARK: - Initialization
    init(searchViewController: SearchViewController) {
        self.searchViewController = searchViewController
    }

    // MARK: - Lifecycle
    func start() {

    }
}
