//
//  PositionComponentData.swift
//  Betterpick
//
//  Created by David Bielik on 02/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct PositionComponentData {
    let positions = PlayerPosition.allCasesWithNilInserted
    let exactPositions: [PlayerPosition?: [ExactPlayerPosition?]]

    init() {
        var dict: [PlayerPosition?: [ExactPlayerPosition?]] = [:]
        for position in positions {
            switch position {
            case .none:
                dict[position] = []
            case .some(let position):
                let exactPositions = position.exactPositions
                guard exactPositions.count > 1 else {
                    dict[position] = exactPositions
                    break
                }
                dict[position] = exactPositions.withNilInserted()
            }
        }
        exactPositions = dict
    }
}
