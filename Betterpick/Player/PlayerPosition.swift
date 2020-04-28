//
//  PlayerPosition.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum PlayerPosition: String, Hashable, CaseIterable, Decodable {
    case goalkeeper
    case defence
    case middle
    case attack

    init(exact position: ExactPlayerPosition) {
        switch position {
        case _ where ExactPlayerPosition.goalkeeper.contains(position): self = .goalkeeper
        case _ where ExactPlayerPosition.defence.contains(position): self = .defence
        case _ where ExactPlayerPosition.middle.contains(position): self = .middle
        case _ where ExactPlayerPosition.attack.contains(position): self = .attack
        // FIXME: Possible fixme to introduce a failable initializer
        default: self = .goalkeeper
        }
    }
}
