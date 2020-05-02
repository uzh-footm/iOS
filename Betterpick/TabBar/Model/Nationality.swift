//
//  Nationality.swift
//  Betterpick
//
//  Created by David Bielik on 29/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct Nationality: Codable, Equatable {
    let name: String
    let logoURL: URL

    private enum Keys: String, CodingKey {
        // swiftlint:disable identifier_name
        case id
        // swiftlint:enable identifier_name
        case logo
    }

    init(name: String, logoURL: URL) {
        self.name = name
        self.logoURL = logoURL
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decode(String.self, forKey: .id)
        logoURL = try container.decode(URL.self, forKey: .logo)
    }
}
