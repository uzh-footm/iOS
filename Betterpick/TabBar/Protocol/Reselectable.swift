//
//  Reselectable.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// Conforming classes to this protocol are able to be "reselected" on the TabBar. Behavior of reselection is class specific.
protocol Reselectable: UIViewController {
    func reselect()
}
