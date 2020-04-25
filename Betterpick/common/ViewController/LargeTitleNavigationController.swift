//
//  LargeTitleNavigationController.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class LargeTitleNavigationController: UINavigationController, NavigationBarProviding {

    static func initWithLargeNavBar() -> LargeTitleNavigationController {
        return LargeTitleNavigationController(navigationBarClass: LargeNavigationBar.self, toolbarClass: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideNavigationBar()
        navigationBar.tintColor = .primary
        navigationBar.prefersLargeTitles = true
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        if #available(iOS 13, *) {} else {
            // Fix for iOS 12 navigation bar animation while changing from hideNavigationBar and showNavigationBar.
            // Without this fix the navigation bar shadow stays put until the animation is finished.
            navigationBar.shadowImage = UIImage()
        }
        return super.popViewController(animated: animated)
    }
}

extension LargeTitleNavigationController: Reselectable {
    func reselect() {
        popToRootViewController(animated: true)
    }
}
