//
//  SettingsCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SettingsCoordinator: TabbedCoordinator {

    // MARK: - Properties
    let settingsViewController: UIViewController

    // TabbedCoordinator implemenation
    var viewController: UIViewController {
        return settingsViewController
    }

    // MARK: - Initialization
    init(settingsViewController: SettingsViewController) {
        self.settingsViewController = settingsViewController
    }

    func start() {}

}
