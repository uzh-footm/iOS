//
//  CaseIterable+Util.swift
//  Betterpick
//
//  Created by David Bielik on 02/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

extension CaseIterable {

    /// Convenience init that enables any `CaseIterable` enum to be initialized from an Index (e.g. `Int`)
    init(from row: AllCases.Index) {
        self = Self.allCases[row]
    }

    /// Returns `CaseIterable.allCases` with each element being an optional. First element of the collection is nil.
    static var allCasesWithNilInserted: [Self?] {
        return [Self].insertNilToCollection(Self.allCases)
    }
}
