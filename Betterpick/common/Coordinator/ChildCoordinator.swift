//
//  ChildCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol ChildCoordinator: Coordinator {
    var viewController: UIViewController { get }
}
