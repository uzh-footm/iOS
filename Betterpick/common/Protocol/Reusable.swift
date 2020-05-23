//
//  Reusable.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}
