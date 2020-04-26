//
//  BetterpickAPIManager.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class BetterpickAPIManager {

    typealias Callback<ResponseBody: Decodable> = (ManagerResult<ResponseBody>) -> Void

    // MARK: - Result Values
    enum ManagerResultError: Error {
        case userNetwork
        case server
    }

    enum ManagerResult<ResponseBody: Decodable> {
        case error(ManagerResultError)
        case success(ResponseBody)
    }

    // MARK: - Properties
    // MARK: Constant
    private static let requestTimeout: TimeInterval = 20
    private static let baseURL = URL(string: "https://betterpick.dvdblk.com/api/v1")!

    let apiHandler: BetterpickAPIHandler

    // MARK: - Initialization
    init(apiHandler: BetterpickAPIHandler = URLSession.shared) {
        self.apiHandler = apiHandler
    }

    // MARK: - Open
    open func apiRequest(endpoint: CustomStringConvertible, method: HTTPMethod, parameters: HTTPParameters?) -> URLRequest {
        var url = URL(string: endpoint.description, relativeTo: BetterpickAPIManager.baseURL) ?? BetterpickAPIManager.baseURL
        if let requestParameters = parameters {
            for parameter in requestParameters {
                url = url.append(parameter.key, value: parameter.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            }
        }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: BetterpickAPIManager.requestTimeout)
        request.httpMethod = method.rawValue
        return request
    }

    // MARK: - Private
    private func createApiCompletionHandler<ResponseBody: Decodable>(managerCompletion: @escaping Callback<ResponseBody>) -> ((BetterpickAPIResponseContext<ResponseBody>) -> Void) {
        return { responseContext in
            switch responseContext {
            case .error(let context):
                switch context.error {
                case .invalidStatusCode, .invalidResponseBody, .responseDataIsNil, .urlResponseNotCreated, .unknown:
                    managerCompletion(.error(.server))
                case .urlSession:
                    managerCompletion(.error(.userNetwork))
                }
            case .response(let body):
                managerCompletion(.success(body))
            }
        }
    }

    func perform<ResponseBody: Decodable>(requestContext: BetterpickAPIRequestContext<ResponseBody>, managerCompletion: @escaping Callback<ResponseBody>) {
        let apiCompletionHandler = createApiCompletionHandler(managerCompletion: managerCompletion)
        apiHandler.perform(requestContext: requestContext, completionHandler: apiCompletionHandler)
    }

    // MARK: - Requests
    // MARK: GET /leagues
    func leagues(completion: @escaping Callback<GetLeaguesResponseBody>) {
        let endpoint = "/leagues"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetLeaguesResponseBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /leagues/{leagueID}
    func league(leagueID: String, completion: @escaping Callback<GetLeagueResponseBody>) {
        let endpoint = "/leagues/\(leagueID)"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetLeagueResponseBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /players/clubs/{clubID}
    func club(clubID: String, completion: @escaping Callback<GetClubResponseBody>) {
        let endpoint = "/players/clubs/\(clubID)"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetClubResponseBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }
}
