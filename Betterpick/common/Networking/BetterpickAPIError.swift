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
    case invalidResponseBody(Decodable.Type, String)
    case urlSession(error: Error)

    public var description: String {
        switch self {
        case .unknown: return "unknown"
        case .urlResponseNotCreated: return "Url response couldn't be created"
        case .responseDataIsNil: return "Response data was nil"
        case .invalidStatusCode(let statusCode): return "Invalid status code: \(statusCode)"
        case .invalidResponseBody(let bodyType, let actualData): return "Couldn't match \(actualData) with \(bodyType)"
        case .urlSession(let underlyingError): return "URLSession error: \(underlyingError)"
        }
    }

    enum UserFriendly: Error {
        case userNetwork
        case server

        init(betterpickAPIError: BetterpickAPIError) {
            switch betterpickAPIError {
            case .invalidStatusCode, .invalidResponseBody, .responseDataIsNil, .urlResponseNotCreated, .unknown:
                self = .server
            case .urlSession:
                self = .userNetwork
            }
        }
    }

    var userFriendlyMessage: String {
        let errorCode = "BetterpickErrorCode"
        switch self {
        case .unknown: return "Unknown error occured."
        case .urlResponseNotCreated: return "\(errorCode) 50"
        case .responseDataIsNil: return "\(errorCode) 51"
        case .invalidStatusCode(let statusCode): return "\(errorCode) 52 (\(statusCode))"
        case .invalidResponseBody: return "\(errorCode) 53"
        case .urlSession(let error):
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                return "\(errorCode) 54, URLSession \(error.code)"
            }
            return "\(errorCode) 54"
        }
    }
}
