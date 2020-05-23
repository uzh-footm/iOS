//
//  LeagueAndNationalityData.swift
//  Betterpick
//
//  Created by David Bielik on 29/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct LeagueAndNationalityData: Decodable {
    let leagues: [League]
    let nationalities: [Nationality]
}
