//
//  ReusableCell.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

typealias ReusableCell = UITableViewCell & Reusable

extension UITableView {
    /// Registers the cell for reuse
    func register(reusable cell: ReusableCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    /// Registers all cells for reuse
    func register(reusable cells: [ReusableCell.Type]) {
        for cell in cells {
            register(reusable: cell)
        }
    }

    /// Dequeue a reusable cell
    /// - note: sugar for `dequeueReusableCell(withIdentifier:for:)`
    func dequeue<T: ReusableCell>(reusableCell: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: reusableCell.reuseIdentifier, for: indexPath) as? T
    }
}
