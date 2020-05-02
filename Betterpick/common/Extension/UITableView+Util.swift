//
//  UITableView+Util.swift
//  Betterpick
//
//  Created by David Bielik on 22/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension UITableView {
    func dontShowEmptyCells() {
        tableFooterView = UIView()
    }

    func removeLastSeparatorAndDontShowEmptyCells() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 0.5))
    }
}
