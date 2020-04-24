//
//  BetterpickAPIError.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum BetterpickAPIError: Error, CustomStringConvertible {
    case unknown
    case urlResponseNotCreated
    case responseDataIsNil
    case invalidStatusCode(Int)
    case invalidResponseBody(Decodable.Type)
    case urlSession(error: Error)

    public var description: String {
        switch self {
        case .unknown: return "unknown"
        case .urlResponseNotCreated: return "Url response couldn't be created"
        case .responseDataIsNil: return "Response data was nil"
        case .invalidStatusCode(let statusCode): return "Invalid status code: \(statusCode)"
        case .invalidResponseBody(let bodyType): return "Couldn't match response body with \(bodyType)"
        case .urlSession(let underlyingError): return "URLSession error: \(underlyingError)"
        }
    }
}
