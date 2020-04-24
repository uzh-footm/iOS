//
//  URLRequest+Add.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

extension URLRequest {
    /// convenience function to add a HTTPHeader into self
    mutating func add(header: HTTPHeader) {
        addValue(header.value, forHTTPHeaderField: header.field)
    }
}
