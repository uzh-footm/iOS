//
//  League.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class League: Codable {
    let name: String
    let leagueId: String

    var teams: [TeamPreview]?

    init(name: String, leagueId: String) {
        self.name = name
        self.leagueId = leagueId
    }
}
