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

    /// The base CDN URL used for SOFIFA player photo fetching
    private static let sofifaPhotoBaseURL: URL = URL(string: "https://cdn.sofifa.com/players/")!
    private static let sofifaPhotoSuffix = "19_120.png"
    private static let expectedPhotoIDLength = 6

    /// Returns a working FIFA 20 dataset URL for the player photos.
    var actualPhoto: URL {
        var playerPhotoID = photo.deletingPathExtension().lastPathComponent
        let maxLength = PlayerPreview.expectedPhotoIDLength
        while playerPhotoID.count < maxLength {
            playerPhotoID = "0" + playerPhotoID
        }
        let split1 = playerPhotoID[0..<maxLength/2]
        let split2 = playerPhotoID[maxLength/2..<maxLength]

        var result = PlayerPreview.sofifaPhotoBaseURL
        result = result.appendingPathComponent(split1).appendingPathComponent(split2)
        return result.appendingPathComponent(PlayerPreview.sofifaPhotoSuffix)
    }
}

// https://stackoverflow.com/questions/45497705/subscript-is-unavailable-cannot-subscript-string-with-a-countableclosedrange
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
