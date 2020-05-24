//
//  DiscoverSection.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum DiscoverSection: Int, CaseIterable {
    case teams
    case players

    var sectionTitle: String {
        switch self {
        case .teams: return "Teams"
        case .players: return "Players"
        }
    }
}
