//
//  BetterpickAPIManagerMock.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class BetterpickAPIManagerMock: BetterpickAPIManager {

    let leagues: [League] = [
        League(name: "Bundesliga", leagueId: "0"),
        League(name: "2. Bundesliga", leagueId: "1"),
        League(name: "Premier League", leagueId: "2"),
        League(name: "EFL Championship", leagueId: "3"),
        League(name: "Swiss Super League", leagueId: "4"),
        League(name: "La Liga", leagueId: "5")
    ]

    let teams: [TeamPreview]

    override init(apiHandler: BetterpickAPIHandler = URLSession.shared) {
        let teamTuples = [
            ("FC Augsburg", "https://www.bundesliga.com/assets/clublogo/fca.png"),
            ("Bayer Leverkusen", "https://www.bundesliga.com/assets/clublogo/b04.png"),
            ("FC Bayern München", "https://www.bundesliga.com/assets/clublogo/fcb.png"),
            ("Borussia Dortmund", "https://www.bundesliga.com/assets/clublogo/bvb.png"),
            ("Borussia Mönchengladbach", "https://www.bundesliga.com/assets/clublogo/bmg.png"),
            ("Eintracht Frankfurt", "https://www.bundesliga.com/assets/clublogo/sge.png"),
            ("Fortuna Düsseldorf", "https://www.bundesliga.com/assets/clublogo/f95.png"),
            ("Hertha BSC", "https://www.bundesliga.com/assets/clublogo/bsc.png"),
            ("TSG Hoffenheim", "https://www.bundesliga.com/assets/clublogo/tsg.png"),
            ("1. FC Köln", "https://www.bundesliga.com/assets/clublogo/koe.png"),
            ("Mainz 05", "https://www.bundesliga.com/assets/clublogo/m05.png"),
            ("SC Paderborn", "https://www.bundesliga.com/assets/clublogo/scp.png"),
            ("RB Leipzig", "https://www.bundesliga.com/assets/clublogo/rbl.png"),
            ("SC Freiburg", "https://www.bundesliga.com/assets/clublogo/scf.png"),
            ("Schalke 04", "https://www.bundesliga.com/assets/clublogo/s04.png"),
            ("Union Berlin", "https://www.bundesliga.com/assets/clublogo/fcu.png"),
            ("Werder Bremen", "https://www.bundesliga.com/assets/clublogo/svw.png"),
            ("VfL Wolfsburg", "https://www.bundesliga.com/assets/clublogo/wob.png")
        ]
        var teams = [TeamPreview]()
        for (index, (name, photoUrlString)) in teamTuples.enumerated() {
            let team = TeamPreview(teamId: String(index), name: name, logoURL: URL(string: photoUrlString)!)
            teams.append(team)
        }
        self.teams = teams
        super.init()
    }

    // MARK: - Mock Helpers
    private func returnSuccessAfter<Response: Decodable>(duration: TimeInterval = 1.5, completion: @escaping Callback<Response>, response: Response) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion(.success(response))
        }
    }

    private func getPlayers(range: Range<Int> = 28..<34) -> [PlayerPreview] {
        let photos = [
            "https://cdn.sofifa.com/players/009/014/19_120.png",
            "https://cdn.sofifa.com/players/164/240/20_120.png",
            "https://cdn.sofifa.com/players/239/085/20_120.png"
        ]
        var playerPreviews = [PlayerPreview]()
        for index in 0..<Int.random(in: range) {
            let randomPosition = PlayerPosition.allCases.randomElement()!
            let preview = PlayerPreview(playerId: String(index), name: "\(randomString(length: Int.random(in: 3..<12))) \(randomString(length: Int.random(in: 3..<12)))", photoURL: URL(string: photos.shuffled().first!)!, squadNumber: Int.random(in: 1..<40), position: randomPosition, nation: randomString(length: 10))
            playerPreviews.append(preview)
        }
        return playerPreviews
    }

    // MARK: - Inherited
    // MARK: GET /leagues
    override func leagues(completion: @escaping BetterpickAPIManager.Callback<GetLeaguesResponseBody>) {
        returnSuccessAfter(duration: 1, completion: completion, response: GetLeaguesResponseBody(leagues: leagues))
    }

    // MARK: GET /leagues/{leagueID}
    override func league(leagueID: String, completion: @escaping BetterpickAPIManager.Callback<GetLeagueResponseBody>) {

        returnSuccessAfter(duration: 0.5, completion: completion, response: GetLeagueResponseBody(teams: teams))
    }

    // Generating Random String
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    // MARK: GET /players/clubs/{clubID}
    override func club(clubID: String, completion: @escaping Callback<GetClubResponseBody>) {
        returnSuccessAfter(duration: 0.6, completion: completion, response: GetClubResponseBody(players: getPlayers()))
    }

    // MARK: GET /players/{playerID}
    override func player(playerID: String, completion: @escaping BetterpickAPIManager.Callback<Player>) {
        let player = Player(id: 0, name: "Asd", age: 0, photo: URL(string: "https://cdn.sofifa.com/players/158/023/20_120.png")!, nationality: "Arg", overall: 94, value: 95000000, wage: 540000, releaseClause: 9999, preferredFoot: "Left", skillMoves: 5, workRate: "Medium/Low", position: .attack, jerseyNumber: 10, height: "kek", weight: 9)
        returnSuccessAfter(duration: 0.6, completion: completion, response: player)
    }

    // MARK: GET /search?name=...
    override func search(name: String, completion: @escaping BetterpickAPIManager.Callback<GetSearchResponseBody>) {
        let searchResultPlayers = getPlayers(range: 0..<4)
        let searchResultClubs = teams.shuffled().dropLast(Int.random(in: 14...18))
        let searchResult = GetSearchResponseBody(players: searchResultPlayers, clubs: Array(searchResultClubs))
        returnSuccessAfter(duration: 0.4, completion: completion, response: searchResult)
    }
}
