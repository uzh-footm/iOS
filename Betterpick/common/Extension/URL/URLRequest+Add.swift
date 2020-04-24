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

    /// convenience function for adding a request body
    /// - returns: true if serialization passed, false otherwise
    @discardableResult
    mutating func addBody<T: Encodable>(_ body: T) -> Bool {
        do {
            httpBody = try JSONEncoder().encode(body)
        } catch {
            return false
        }
        return true
    }
}
