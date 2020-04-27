//
//  Player.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct Player: Decodable {
    let id: Int
    let name: String
    let age: Int
    let photo: URL
    let nationality: String
    let overall: Int
    // FIXME: what to do with the club doe?
    //let club: TeamPreview
    let value: Int
    let wage: Int
    let releaseClause: Int
    let preferredFoot: String
    let skillMoves: Int
    let workRate: String
    let position: PlayerPosition
    let jerseyNumber: Int
    let height: String
    let weight: Int
}
