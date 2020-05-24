//
//  BetterpickAPIRequestErrorContext.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct BetterpickAPIRequestErrorContext<ResponseBody: Decodable> {
    let error: BetterpickAPIError
    let requestContext: BetterpickAPIRequestContext<ResponseBody>
}

extension BetterpickAPIRequestErrorContext: CustomStringConvertible {
    var description: String {
        return "[BetterpickAPIRequestErrorContext] err=\(error.description), requestContext=\(requestContext.description)"
    }
}
