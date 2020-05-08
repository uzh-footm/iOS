//
//  PlayerPreview.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct PlayerPreview: Decodable {
    let playerId: String
    let name: String
    let photoURL: URL
    let squadNumber: Int
    let position: ExactPlayerPosition
    let nation: String
    let ovr: Int
    let club: String

    var roughPosition: PlayerPosition {
        return PlayerPosition(exact: position)
    }
}
