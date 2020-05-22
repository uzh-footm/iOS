//
//  Player.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

// Disable Swiftlint for the ID property
struct Player: Decodable {
    let id: Int
    let name: String
    let age: Int
    let photo: URL
    let nationality: String
    let overall: Int
    let club: String
    let value: Int
    let wage: Int
    let releaseClause: Int
    let preferredFoot: String
    let skillMoves: Int
    let workRate: String
    let position: ExactPlayerPosition
    let jerseyNumber: Int
    let height: String
    let weight: Int

    // MARK: - Computed
    var roughPosition: PlayerPosition {
        return PlayerPosition(exact: position)
    }

    var firstName: String? {
        let names = name.components(separatedBy: .whitespaces)
        guard names.count > 1, let firstName = names.first else { return nil }
        return firstName
    }

    var surname: String {
        var names = name.components(separatedBy: .whitespaces)
        guard names.count > 1 else { return name }
        names.removeFirst()
        return names.joined(separator: " ")
    }
    
    /// Returns a working FIFA 20 dataset URL for the player photos.
    var actualPhoto: URL {
        return ImageURLProcessor.playerPhoto(photoURL: photo)
    }

    // MARK: - Skills
    let crossing: Int
    let finishing: Int
    let headingAccuracy: Int
    let shortPassing: Int
    let volleys: Int
    let dribbling: Int
    let curve: Int
    let fkAccuracy: Int
    let longPassing: Int
    let ballControl: Int
    let acceleration: Int
    let sprintSpeed: Int
    let agility: Int
    let reactions: Int
    let balance: Int
    let shotPower: Int
    let jumping: Int
    let stamina: Int
    let strength: Int
    let longshots: Int
    let aggression: Int
    let interceptions: Int
    let positioning: Int
    let vision: Int
    let penalties: Int
    let composure: Int
    let marking: Int
    let standingTackle: Int
    let slidingTackle: Int
    let gkDiving: Int
    let gkHandling: Int
    let gkKicking: Int
    let gkPositioning: Int
    let gkReflexes: Int

    // MARK: Skill Categories
    typealias SkillKeyPaths = [KeyPath<Player, Int>]
    static let attackingSkillKeyPaths: SkillKeyPaths = [\Player.crossing, \Player.finishing, \Player.headingAccuracy, \Player.shortPassing, \Player.volleys]
    static let ballSkillSkillKeyPaths: SkillKeyPaths = [\Player.dribbling, \Player.curve, \Player.fkAccuracy, \Player.longPassing, \Player.ballControl]
    static let movementSkillKeyPaths: SkillKeyPaths = [\Player.acceleration, \Player.sprintSpeed, \Player.agility, \Player.reactions, \Player.balance]
    static let powerSkillKeyPaths: SkillKeyPaths = [\Player.shotPower, \Player.jumping, \Player.stamina, \Player.strength, \Player.longshots]
    static let mentalitySkillKeyPaths: SkillKeyPaths = [\Player.aggression, \Player.interceptions, \Player.positioning, \Player.vision, \Player.penalties, \Player.composure]
    static let defendingSkillKeyPaths: SkillKeyPaths = [\Player.marking, \Player.standingTackle, \Player.slidingTackle]
    static let goalkeepingSkillKeyPaths: SkillKeyPaths = [\Player.gkDiving, \Player.gkHandling, \Player.gkKicking, \Player.gkPositioning, \Player.gkReflexes]

    // MARK: - Public
    public func createNameValuePairs(keyPaths: SkillKeyPaths) -> [(skill: String, value: Int)] {
        var result = [(String, Int)]()
        for keyPath in keyPaths {
            let skillName = keyPath.string
            let value = self[keyPath: keyPath]
            result.append((skillName, value))
        }
        return result
    }
}

extension KeyPath where Root == Player {
    var string: String {
        switch self {
        case (\Player.crossing): return "Crossing"
        case (\Player.finishing): return "Finishing"
        case (\Player.headingAccuracy): return "Heading Acc."
        case (\Player.shortPassing): return "Short Passing"
        case (\Player.volleys): return "Volleys"
        case (\Player.dribbling): return "Dribbling"
        case (\Player.curve): return "Curve"
        case (\Player.fkAccuracy): return "Freekick Acc."
        case (\Player.longPassing): return "Long Passing"
        case (\Player.ballControl): return "Ball Control"
        case (\Player.acceleration): return "Acceleration"
        case (\Player.sprintSpeed): return "Sprint Speed"
        case (\Player.agility): return "Agility"
        case (\Player.reactions): return "Reactions"
        case (\Player.balance): return "Balance"
        case (\Player.shotPower): return "Shot Power"
        case (\Player.jumping): return "Jumping"
        case (\Player.stamina): return "Stamina"
        case (\Player.strength): return "Strength"
        case (\Player.longshots): return "Longshots"
        case (\Player.aggression): return "Aggression"
        case (\Player.interceptions): return "Interceptions"
        case (\Player.positioning): return "Positioning"
        case (\Player.vision): return "Vision"
        case (\Player.penalties): return "Penalties"
        case (\Player.composure): return "Composure"
        case (\Player.marking): return "Marking"
        case (\Player.standingTackle): return "Standing Tackle"
        case (\Player.slidingTackle): return "Sliding Tackle"
        case (\Player.gkDiving): return "GK Diving"
        case (\Player.gkHandling): return "GK Handling"
        case (\Player.gkKicking): return "GK Kicking"
        case (\Player.positioning): return "GK Positioning"
        case (\Player.gkReflexes): return "GK Reflexes"
        default: return "Unknown"
        }
    }
}
