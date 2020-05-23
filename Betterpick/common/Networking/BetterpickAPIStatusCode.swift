//
//  BetterpickAPIStatusCode.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum BetterpickAPIStatusCode: HTTPStatusCode {
    case success = 200
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case internalServerError = 500
}
