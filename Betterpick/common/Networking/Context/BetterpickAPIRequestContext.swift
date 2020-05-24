//
//  BetterpickAPIRequestContext.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// Each network request has it's own request context. It is defined by the type of the `ResponseBody` and a `URLRequest`.
struct BetterpickAPIRequestContext<ResponseBody: Decodable> {
    let responseBodyType: ResponseBody.Type
    let apiRequest: URLRequest
}

// MARK: - CustomStringConvertible
extension BetterpickAPIRequestContext: CustomStringConvertible {
    var description: String {
        return "responseBodyType=\(responseBodyType), apiRequest=\(apiRequest)"
    }
}
