//
//  PlayerFilterData.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct PlayerFilterData: Encodable {

    enum SortBy: String, Encodable {
        case asc
        case desc
    }

    var sortBy: SortBy

    static func `default`() -> PlayerFilterData {
        return PlayerFilterData(sortBy: .asc)
    }
}
