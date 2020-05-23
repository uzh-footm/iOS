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
    /// - returns: `true` if the class handled the reselection, `false` otherwise
    func reselect() -> Bool
}

extension Reselectable {
    func reselect() -> Bool {
        return reselectChildViewControllers()
    }

    @discardableResult
    /// Reselects all the childviewcontrollers that are also `Reselectable`
    /// - returns: `true` if any of the Reselectable child VCs got reselected, `false` otherwise
    func reselectChildViewControllers() -> Bool {
        for childVC in children {
            guard let reselectableVC = childVC as? Reselectable, reselectableVC.reselect() else { continue }
            return true
        }
        return false
    }
}

protocol TableViewReselectable: Reselectable {
    var tableView: UITableView { get }
}

extension TableViewReselectable {
    func reselect() -> Bool {
        tableView.setContentOffset(.zero, animated: true)
        return true
    }
}
