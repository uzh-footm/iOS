//
//  APIIntegrationTests.swift
//  BetterpickTests
//
//  Created by David Bielik on 20/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import XCTest
@testable import Betterpick

class APIIntegrationTests: XCTestCase {

    // MARK: - Properties
    var apiManager: BetterpickAPIManager {
        return BetterpickAPIManager()
    }

    func commonCompletion<T>(expectation: XCTestExpectation) -> BetterpickAPIManager.Callback<T> {
        return { (response) in
            switch response {
            case .error(let error, let underlyingError):
                print("Request error \(error) | underlying \(underlyingError)")
            case .success:
                expectation.fulfill()
            }
        }
    }

    // MARK: - Tests
    // MARK: Common
    func testCommonCompletionSuccess() {
        let successfulExpectation = expectation(description: "Completion should fulfill this expectation")

        let completion: BetterpickAPIManager.Callback<String> = commonCompletion(expectation: successfulExpectation)
        completion(.success(""))

        wait(for: [successfulExpectation], timeout: 0.5)
    }

    func testCommonCompletionError() {
        let failedExpectation = expectation(description: "Completion should not fulfill this expectation")
        failedExpectation.isInverted = true

        let completion: BetterpickAPIManager.Callback<String> = commonCompletion(expectation: failedExpectation)
        completion(.error(.server, .unknown))

        wait(for: [failedExpectation], timeout: 0.5)
    }

    // MARK: - Endpoints
    func testGetLeagues() {
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.leagues(completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }

    func testGetNationalities() {
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.nationalities(completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }

    func testGetLeagueID() {
        let requestSuccessExpectation = expectation(description: "Request should return 200.")
        let manager = apiManager

        manager.leagues { (response) in
            switch response {
            case .error(let error, _):
                print("Error \(error)")
            case .success(let leagues):
                guard let firstLeague = leagues.first else { break }
                manager.league(leagueID: firstLeague.id, completion: self.commonCompletion(expectation: requestSuccessExpectation))
            }
        }

        wait(for: [requestSuccessExpectation], timeout: 4)
    }

    func testGetClubPlayers() {
        let club = "CD Everton de Viña del Mar"
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.clubPlayers(clubID: club, completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }

    func testGetPlayerFull() {
        let playerID = String(188350)
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.player(playerID: playerID, completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }
    
    func testGetSearchPlayers() {
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.searchPlayers(name: "Messi", completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }
    
    func testGetSearchClubs() {
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.searchClubs(name: "Barcelona", completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }

    func testGetPlayersSearch() {
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.players(filterData: PlayerFilterData(), completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 10)
    }

    func testGetClub() {
        let clubID = "Borussia Dortmund"
        let requestSuccessExpectation = expectation(description: "Request should return 200.")

        apiManager.club(clubID: clubID, completion: commonCompletion(expectation: requestSuccessExpectation))

        wait(for: [requestSuccessExpectation], timeout: 4)
    }
}
