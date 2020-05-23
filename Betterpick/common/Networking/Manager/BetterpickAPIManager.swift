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
    enum ManagerResult<ResponseBody: Decodable> {
        case error(BetterpickAPIError)
        case success(ResponseBody)
    }

    // MARK: - Properties
    // MARK: Constant
    private static let requestTimeout: TimeInterval = 20
    private static let baseURL = URL(string: "http://localhost:8080")!

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
                managerCompletion(.error(context.error))
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

    // MARK: GET /nationalities
    func nationalities(completion: @escaping Callback<GetNationalitiesBody>) {
        let endpoint = "/nationalities"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetNationalitiesBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /clubs/league/{leagueID}
    func league(leagueID: String, completion: @escaping Callback<GetLeagueResponseBody>) {
        let endpoint = "/clubs/league/\(leagueID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetLeagueResponseBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /players/clubs/{clubID}
    func clubPlayers(clubID: String, completion: @escaping Callback<GetClubPlayersResponseBody>) {
        let endpoint = "/players/club/\(clubID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetClubPlayersResponseBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /players/{playerID}/full
    func player(playerID: String, completion: @escaping Callback<Player>) {
        let endpoint = "/players/\(playerID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")/full"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: Player.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    private func commonSearch<T: Decodable>(resultType: String, name: String, completion: @escaping Callback<T>) {
        let endpoint = resultType + "/search/" + name
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: T.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /clubs/search/{name}
    func searchClubs(name: String, completion: @escaping Callback<GetClubsSearchResponseBody>) {
        commonSearch(resultType: "/clubs", name: name, completion: completion)
    }

    // MARK: GET /players/search/{name}
    func searchPlayers(name: String, completion: @escaping Callback<GetPlayersSearchResponseBody>) {
        commonSearch(resultType: "/players", name: name, completion: completion)
    }

    // MARK: GET /players
    /// Filter between players with `PlayerFilterData`
    func players(filterData: PlayerFilterData, completion: @escaping Callback<GetPlayersResponseBody>) {
        let endpoint = "/players"
        let parameters = filterData.parameters
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: parameters)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: GetPlayersResponseBody.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }

    // MARK: GET /clubs/{clubID}
    func club(clubID: String, completion: @escaping Callback<TeamPreview>) {
        let endpoint = "/clubs/\(clubID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let request = apiRequest(endpoint: endpoint, method: .get, parameters: nil)
        let requestContext = BetterpickAPIRequestContext(responseBodyType: TeamPreview.self, apiRequest: request)
        perform(requestContext: requestContext, managerCompletion: completion)
    }
}
