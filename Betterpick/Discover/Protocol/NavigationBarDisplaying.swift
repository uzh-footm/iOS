//
//  NavigationBarDisplaying.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol NavigationBarDisplaying {}

extension NavigationBarDisplaying where Self: UIViewController {
    func hideNavigationBar() {
        guard let navigationController = navigationController as? NavigationBarProviding else { return }
        navigationController.hideNavigationBar()
    }

    func showNavigationBar() {
        guard let navigationController = navigationController as? NavigationBarProviding else { return }
        navigationController.showNavigationBar()
    }

    func hideBackBarButtonText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
