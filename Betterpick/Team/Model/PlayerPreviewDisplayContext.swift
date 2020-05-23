//
//  PlayerPreviewDisplayContext.swift
//  Betterpick
//
//  Created by David Bielik on 08/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// OptionSet representing the different values that should be displayed by a `PlayerPreviewTableViewCell`
struct PlayerPreviewDisplayContext: OptionSet {
    let rawValue: Int

    static let showsExactPosition = PlayerPreviewDisplayContext(rawValue: 1 << 0)
    static let showsNationality = PlayerPreviewDisplayContext(rawValue: 1 << 1)
    static let showsClub = PlayerPreviewDisplayContext(rawValue: 1 << 2)
    static let showsOvr = PlayerPreviewDisplayContext(rawValue: 1 << 3)

    static let all: PlayerPreviewDisplayContext = [.showsExactPosition, .showsNationality, .showsClub, .showsOvr]
}
