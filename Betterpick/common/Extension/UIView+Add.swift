//
//  UIView+Add.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension UIView {
    /// Convenience function for adding a subview that is going to be managed by autolayout.
    /// - parameter subview: the subview that will be added to `self` and has its `translatesAutoresizingMaskIntoConstraints` set to `false`
    func add(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
}
