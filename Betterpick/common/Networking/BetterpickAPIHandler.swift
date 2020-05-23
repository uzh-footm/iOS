//
//  BetterpickAPIHandler.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

protocol BetterpickAPIHandler {
    func perform<ResponseBody: Decodable>(requestContext: BetterpickAPIRequestContext<ResponseBody>, completionHandler: @escaping ((BetterpickAPIResponseContext<ResponseBody>) -> Void))
}
