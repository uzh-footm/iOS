//
//  Collection+NilInsertions.swift
//  Betterpick
//
//  Created by David Bielik on 02/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

extension Collection {

    /// Changes the type of `Element` to `Optional(Element)` and inserts a nil value at the head of the collection
    static func insertNilToCollection<T: Collection>(_ array: T) -> [T.Element?] where T.Element: CaseIterable {
        var positions = array.map { Optional($0) }
        positions.insert(nil, at: 0)
        return positions
    }

    /// Convenience for calling `Collection.insertNilToCollection`
    func withNilInserted<E: CaseIterable>() -> [E?] where Self.Element == E {
        return Self.insertNilToCollection(self)
    }
}
