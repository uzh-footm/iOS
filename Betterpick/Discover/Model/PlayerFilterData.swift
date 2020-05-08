//
//  PlayerFilterData.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct PlayerFilterData: Encodable, Equatable {

    enum SortOrder: Int, Encodable, CaseIterable, CustomStringConvertible {
        case desc
        case asc

        var bestOrWorst: String {
            return self == .asc ? "worst" : "best"
        }

        var description: String {
            return "Show \(bestOrWorst) players first"
        }
    }

    // MARK: - Sort Section
    // Sort
    var sortOrder: SortOrder = .desc

    // MARK: - Player Section
    // MARK: Nationality
    /// nil value represents 'Any nationality'
    var nationality: Nationality?
    // MARK: Position
    /// nil value represents 'Any position'
    var position: PlayerPosition?
    /// nil value represents 'Any { Goalkeeper | Defender | Midfielder | Striker }
    /// depends on position
    var exactPosition: ExactPlayerPosition?
    // MARK: OVR
    var ovrGreatherThanOrEqual: Int = PlayerFilterData.minimumOvr
    var ovrLessThanOrEqual: Int = PlayerFilterData.maximumOvr

    var ovrRangeText: String {
        let lower = ovrGreatherThanOrEqual
        let upper = ovrLessThanOrEqual
        if lower == upper {
            return "\(lower)"
        } else {
            let lowerText: String = lower == PlayerFilterData.minimumOvr ? PlayerFilterData.defaultAnyValueText : "\(lower)"
            let upperText: String = upper == PlayerFilterData.maximumOvr ? PlayerFilterData.defaultAnyValueText : "\(upper)"
            guard lowerText != upperText else { return PlayerFilterData.defaultAnyValueText }
            return "\(lowerText) - \(upperText)"
        }
    }

    static var minimumOvr: Int = 40
    static var maximumOvr: Int = 100
    static let defaultAnyValueText = "Any"
}

// MARK: - CustomStringConvertible
extension PlayerFilterData: CustomStringConvertible {
    var description: String {
        var playersText = "players"
        if let exactPosition = exactPosition {
            playersText = "'\(exactPosition.rawValue)'"
        } else if let position = position {
            playersText = position.positionText.lowercased() + "s"
        }

        var nationOrDot = "."
        if let nationality = nationality {
            nationOrDot = " from \(nationality.name)."
        }

        var ovrText = ""
        if ovrRangeText != PlayerFilterData.defaultAnyValueText {
            ovrText = " (\(ovrRangeText))"
        }
        return "Showing \(sortOrder.bestOrWorst) \(playersText)\(nationOrDot)\(ovrText)"
    }
}
