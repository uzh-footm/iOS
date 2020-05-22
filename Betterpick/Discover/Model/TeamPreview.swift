//
//  TeamPreview.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// Represents a Team with only the necessary information.
struct TeamPreview: Codable {
    let id: String
    let logo: URL

    var name: String {
        return id
    }

    /// The base CDN URL used for SOFIFA clubs logo fetching
    private static let sofifaClubLogoBaseURL: URL = URL(string: "https://cdn.sofifa.com/teams/")!
    private static let sofifaClubLogoSuffix = "light_240.png"

    var actualLogo: URL {
        let logoID = logo.deletingPathExtension().lastPathComponent

        return TeamPreview.sofifaClubLogoBaseURL.appendingPathComponent(logoID).appendingPathComponent(TeamPreview.sofifaClubLogoSuffix)
    }
}
