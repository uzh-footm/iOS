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
}
