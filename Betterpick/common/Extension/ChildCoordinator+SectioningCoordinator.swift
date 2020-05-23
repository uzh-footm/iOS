//
//  ChildCoordinator+SectioningCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension ChildCoordinator where Self: SectioningCoordinator {
    var viewController: UIViewController {
        return containerViewController
    }
}
