//
//  BetterpickAPIManagerFactory.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct BetterpickAPIManagerFactory {

    static func createAPIManager() -> BetterpickAPIManager {
        #if API_MOCK
            return BetterpickAPIManagerMock()
        #else
            return BetterpickAPIManager()
        #endif
    }
}
