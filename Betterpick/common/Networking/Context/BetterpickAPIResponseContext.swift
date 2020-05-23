//
//  BetterpickAPIResponseContext.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum BetterpickAPIResponseContext<ResponseBody: Decodable> {
    case error(context: BetterpickAPIRequestErrorContext<ResponseBody>)
    case response(body: ResponseBody)
}
