//
//  ExactPlayerPosition.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
enum ExactPlayerPosition: String, CaseIterable, Codable {
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
    case LCM
    case LDM
    case LAM
    case RCM
    case RDM
    case RAM
    case CDM
    case CAM
    case LM
    case RM
    case LWB
    case RWB
    // Attack
    case ST
    case CF
    case LW
    case RW
    case RS
    case LS
    case LF
    case RF

    // MARK: - ExactPositions
    static var goalkeeper: [ExactPlayerPosition] {
        return [.GK]
    }

    static var defence: [ExactPlayerPosition] {
        return [.CB, .LCB, .RCB, .LB, .RB]
    }

    static var middle: [ExactPlayerPosition] {
        return [.CM, .LCM, .LDM, .LAM, .RCM, .RDM, .RAM, .CDM, .CAM, .LM, .RM, .LWB, .RWB]
    }

    static var attack: [ExactPlayerPosition] {
        return [.ST, .CF, .LW, .RW, .RS, .LS, .LF, .RF]
    }
}
