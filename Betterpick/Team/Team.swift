//
//  Team.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class Team {
    let teamId: String
    let name: String
    let logoURL: URL

    var playersPreview: [PlayerPreview]?

    init(from preview: TeamPreview) {
        self.teamId = preview.teamId
        self.name = preview.name
        self.logoURL = preview.logoURL
    }
}
