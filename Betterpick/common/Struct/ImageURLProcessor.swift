//
//  ImageURLProcessor.swift
//  Betterpick
//
//  Created by David Bielik on 22/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// This struct contains static methods responsible for photo / logo URL processing.
/// - note: This struct is used because the photo URLs in the dataset are outdated (unreachable / 404). Our FIFA dataset is from 2019 however, SOFIFA updated their photo/logo URL format in 2020 so these functions help with that.
struct ImageURLProcessor {

    // MARK: Player
    /// The base CDN URL used for SOFIFA player photo fetching
    private static let sofifaPhotoBaseURL: URL = URL(string: "https://cdn.sofifa.com/players/")!
    private static let sofifaPhotoSuffix = "19_120.png"
    private static let expectedPhotoIDLength = 6

    static func playerPhoto(photoURL: URL) -> URL {
        var playerPhotoID = photoURL.deletingPathExtension().lastPathComponent
        while playerPhotoID.count < expectedPhotoIDLength {
            playerPhotoID = "0" + playerPhotoID
        }
        let split1 = playerPhotoID[0..<expectedPhotoIDLength/2]
        let split2 = playerPhotoID[expectedPhotoIDLength/2..<expectedPhotoIDLength]

        var result = sofifaPhotoBaseURL
        result = result.appendingPathComponent(split1).appendingPathComponent(split2)
        return result.appendingPathComponent(sofifaPhotoSuffix)
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
