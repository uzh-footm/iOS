//
//  TabbedCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol TabbedCoordinator: Coordinator {
    var viewController: UIViewController { get }
}
