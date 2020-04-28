//
//  ExactPlayerPosition.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
enum ExactPlayerPosition: String, CaseIterable, Decodable {
    // Goalkeeper
    case GK
    // Defence
    case CB
    case LCB
    case RCB
    case LB
    case RB
    // Middle
    case CM
    case LDM
    case LAM
    case RDM
    case RAM
    case CDM
    case CAM
    case LM
    case RM
    // Attack
    case ST
    case CF
    case LW
    case RW

    static var goalkeeper: [ExactPlayerPosition] {
        return [.GK]
    }

    static var defence: [ExactPlayerPosition] {
        return [.CB, .LCB, .RCB, .LB, .RB]
    }

    static var middle: [ExactPlayerPosition] {
        return [.CM, .LDM, .LAM, .RDM, .RAM, .CDM, .CAM, .LM, .RM]
    }

    static var attack: [ExactPlayerPosition] {
        return [.ST, .CF, .LW, .RW]
    }
}
