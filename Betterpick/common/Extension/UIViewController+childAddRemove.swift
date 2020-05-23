//
//  UIViewController+childAddRemove.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Convenience function for adding a child view controller to the hierarchy
    func add(childViewController child: UIViewController, superview: UIView? = nil) {
        addChild(child)
        let vcSuperview: UIView = superview ?? view
        vcSuperview.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// Convenience function for removing a child view controller from viewcontroller's view hierarchy
    func remove(childViewController child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
