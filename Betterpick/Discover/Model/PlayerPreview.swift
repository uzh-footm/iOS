//
//  PlayerPreview.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct PlayerPreview: Decodable {
    let id: Int
    let name: String
    let photo: URL
    let age: Int
    let jerseyNumber: Int
    let position: ExactPlayerPosition
    let nationality: String
    let overall: Int
    let club: String

    var roughPosition: PlayerPosition {
        return PlayerPosition(exact: position)
    }
}
