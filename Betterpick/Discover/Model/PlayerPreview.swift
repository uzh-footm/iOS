//
//  PlayerPreview.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum PlayerPosition: String, CaseIterable, Decodable {
    case goalkeeper
    case defence
    case middle
    case attack
}

struct PlayerPreview: Decodable {
    let playerId: String
    let name: String
    let photoURL: URL
    let squadNumber: Int
    let position: PlayerPosition
    let nation: String
}
