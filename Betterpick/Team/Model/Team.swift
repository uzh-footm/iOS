//
//  Team.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class Team {
    typealias Squad = [(position: PlayerPosition, players: [PlayerPreview])]

    let name: String
    let logoURL: URL

    var squad: Squad?

    init(from preview: TeamPreview) {
        self.name = preview.name
        self.logoURL = preview.actualLogo
    }

    static func createSquad(previews: [PlayerPreview]) -> Squad {
        var squad = Squad()
        for position in PlayerPosition.allCases {
            var playersAtPosition: [PlayerPreview] = []
            for player in previews where player.roughPosition == position {
                playersAtPosition.append(player)
            }
            guard !playersAtPosition.isEmpty else { continue }
            squad.append((position, playersAtPosition))
        }
        return squad
    }
}
