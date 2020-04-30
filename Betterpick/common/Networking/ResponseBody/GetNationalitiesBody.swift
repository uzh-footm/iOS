//
//  GetNationalitiesBody.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct GetNationalitiesBody: Decodable {
    let nationalities: [Nationality]
}

