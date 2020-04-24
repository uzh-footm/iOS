//
//  URLSession+BetterpickAPIHandler.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

extension URLSession: BetterpickAPIHandler {

    typealias CompletionCallback<ResponseBody: Decodable> = (BetterpickAPIResponseContext<ResponseBody>) -> Void

    private static func finish<ResponseBody: Decodable>(_ maybeResponseBody: ResponseBody?, _ maybeError: BetterpickAPIError?, requestContext: BetterpickAPIRequestContext<ResponseBody>, completion: @escaping CompletionCallback<ResponseBody>) {
        if let betterpickAPIError = maybeError {
            let errorContext = BetterpickAPIRequestErrorContext(error: betterpickAPIError, requestContext: requestContext)
            DispatchQueue.main.async {
                completion(.error(context: errorContext))
            }
        } else if let responseBody = maybeResponseBody {
            DispatchQueue.main.async {
                completion(.response(body: responseBody))
            }
        }
    }

    func perform<ResponseBody: Decodable>(requestContext: BetterpickAPIRequestContext<ResponseBody>, completionHandler: @escaping CompletionCallback<ResponseBody>) {
        // Create a task
        let task = dataTask(with: requestContext.apiRequest) { data, urlResponse, maybeError in
            if let error = maybeError {
                URLSession.finish(nil, .urlSession(error: error), requestContext: requestContext, completion: completionHandler)
                return
            }
            guard let data = data else {
                URLSession.finish(nil, .responseDataIsNil, requestContext: requestContext, completion: completionHandler)
                return
            }
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                URLSession.finish(nil, .urlResponseNotCreated, requestContext: requestContext, completion: completionHandler)
                return
            }
            guard let statusCode = BetterpickAPIStatusCode(rawValue: httpURLResponse.statusCode) else {
                URLSession.finish(nil, .invalidStatusCode(httpURLResponse.statusCode), requestContext: requestContext, completion: completionHandler)
                return
            }
            switch statusCode {
            case .success:
                guard let response = try? JSONDecoder().decode(requestContext.responseBodyType, from: data) else {
                    URLSession.finish(nil, .invalidResponseBody(requestContext.responseBodyType), requestContext: requestContext, completion: completionHandler)
                    return
                }
                URLSession.finish(response, nil, requestContext: requestContext, completion: completionHandler)
            case .noContent:
                let emptyJsonData = Data([0x7B, 0x7D]) // "{}" empty json data
                guard let response = try? JSONDecoder().decode(requestContext.responseBodyType, from: emptyJsonData) else {
                    URLSession.finish(nil, .invalidResponseBody(requestContext.responseBodyType), requestContext: requestContext, completion: completionHandler)
                    return
                }
                URLSession.finish(response, nil, requestContext: requestContext, completion: completionHandler)
            default:
                URLSession.finish(nil, .invalidStatusCode(statusCode.rawValue), requestContext: requestContext, completion: completionHandler)
            }
        }
        // Start it
        task.resume()
    }
}
