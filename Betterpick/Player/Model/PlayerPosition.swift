//
//  PlayerPosition.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

enum PlayerPosition: String, Hashable, CaseIterable, Codable {
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

    var positionText: String {
        switch self {
        case .goalkeeper: return "Goalkeeper"
        case .defence: return "Defender"
        case .middle: return "Midfielder"
        case .attack: return "Attacker"
        }
    }

    var exactPositions: [ExactPlayerPosition] {
        switch self {
        case .goalkeeper: return ExactPlayerPosition.goalkeeper
        case .defence: return ExactPlayerPosition.defence
        case .middle: return ExactPlayerPosition.middle
        case .attack: return ExactPlayerPosition.attack
        }
    }

    var color: UIColor {
        switch self {
        case .goalkeeper: return .positionGoalkeeper
        case .defence: return .positionDefence
        case .middle: return .positionMiddle
        case .attack: return .positionAttack
        }
    }
}
