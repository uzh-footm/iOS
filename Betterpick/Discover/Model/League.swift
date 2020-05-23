//
//  League.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class League: Codable {
    let id: String

    var name: String {
        return id
    }

    var teams: [TeamPreview]?

    init(id: String) {
        self.id = id
    }
}
