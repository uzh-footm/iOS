//
//  TeamListViewController+Reselectable.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension TeamListViewController: Reselectable {
    func reselect() -> Bool {
        tableView.setContentOffset(.zero, animated: true)
        return true
    }
}
