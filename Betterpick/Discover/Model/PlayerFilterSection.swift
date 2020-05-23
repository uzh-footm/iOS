//
//  PlayerFilterSection.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum PlayerFilterSection: Int, CaseIterable {
    case sort
    case playerInfo
    case reset

    var sectionHeaderText: String? {
        switch self {
        case .sort: return "Sorting Order"
        case .playerInfo: return "Player Information"
        case .reset: return nil
        }
    }

    enum PlayerInformation: Int, CaseIterable {
        case nationality
        case position
        case ovrRange
    }
}
