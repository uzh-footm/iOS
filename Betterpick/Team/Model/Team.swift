//
//  Team.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class Team {
    typealias Squad = [PlayerPosition: [PlayerPreview]]

    let teamId: String
    let name: String
    let logoURL: URL

    var squad: Squad?

    init(from preview: TeamPreview) {
        self.teamId = preview.teamId
        self.name = preview.name
        self.logoURL = preview.logoURL
    }

    static func createSquad(previews: [PlayerPreview]) -> Squad {
        var squad = Squad()
        for position in PlayerPosition.allCases {
            var playersAtPosition: [PlayerPreview] = []
            for player in previews where player.position == position {
                playersAtPosition.append(player)
            }
            squad[position] = playersAtPosition
        }
        return squad
    }
}
