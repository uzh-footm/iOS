//
//  GetSearchResponseBody.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct GetSearchResponseBody: Decodable {
    let players: [PlayerPreview]?
    let clubs: [TeamPreview]?
}
