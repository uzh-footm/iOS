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

    let nationalities = [
        Nationality(name: "Germany", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/ba/Flag_of_Germany.svg")!),
        Nationality(name: "Slovakia", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/1920px-Flag_of_Slovakia.svg.png")!),
        Nationality(name: "Greece", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_Greece.svg")!),
        Nationality(name: "Argentina", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/1280px-Flag_of_Argentina.svg.png")!)
    ]

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

    let teams: [TeamPreview]

    override init(apiHandler: BetterpickAPIHandler = URLSession.shared) {
        var teams = [TeamPreview]()
        for (name, photoUrlString) in teamTuples {
            let team = TeamPreview(name: name, logo: URL(string: photoUrlString)!)
            teams.append(team)
        }
        self.teams = teams
        super.init()
    }

    // MARK: - Mock Helpers
    private func returnSuccessAfter<Response: Decodable>(duration: TimeInterval = 0.2, completion: @escaping Callback<Response>, response: Response) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion(.success(response))
        }
    }

    private func getPlayers(range: Range<Int> = 28..<34, ovrRange: ClosedRange<Int>? = nil) -> [PlayerPreview] {
        let photos = [
            "https://cdn.sofifa.com/players/009/014/19_120.png",
            "https://cdn.sofifa.com/players/164/240/20_120.png",
            "https://cdn.sofifa.com/players/239/085/20_120.png"
        ]
        var playerPreviews = [PlayerPreview]()
        for index in 0..<Int.random(in: range) {
            let ovr: Int
            if let ovrRange = ovrRange {
                ovr = Int.random(in: ovrRange)
            } else {
                let ovrBase = [60, 70, 80].randomElement()!
                ovr = Int.random(in: ovrBase...ovrBase+Int.random(in: 0...14))
            }
            let randomPosition = ExactPlayerPosition.allCases.randomElement()!
            let preview = PlayerPreview(playerId: String(index), name: "\(randomString(length: Int.random(in: 3..<12))) \(randomString(length: Int.random(in: 3..<12)))", photoURL: URL(string: photos.shuffled().first!)!, squadNumber: Int.random(in: 1..<40), position: randomPosition, nation: nationalities.randomElement()!.name, ovr: ovr, club: teamTuples.randomElement()!.0)
            playerPreviews.append(preview)
        }
        return playerPreviews
    }

    // MARK: - Inherited
    // MARK: GET /leagues
    override func leagues(completion: @escaping BetterpickAPIManager.Callback<GetLeaguesResponseBody>) {
        returnSuccessAfter(duration: 0.2, completion: completion, response: GetLeaguesResponseBody(leagues: leagues))
    }

    // MARK: GET /nationalities
    override func nationalities(completion: @escaping BetterpickAPIManager.Callback<GetNationalitiesBody>) {
        returnSuccessAfter(completion: completion, response: GetNationalitiesBody(nationalities: nationalities))
    }

    // MARK: GET /leagues/{leagueID}
    override func league(leagueID: String, completion: @escaping BetterpickAPIManager.Callback<GetLeagueResponseBody>) {

        returnSuccessAfter(duration: 0.3, completion: completion, response: GetLeagueResponseBody(teams: teams))
    }

    // Generating Random String
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    // MARK: GET /players/clubs/{clubID}
    override func clubPlayers(clubID: String, completion: @escaping Callback<GetClubPlayersResponseBody>) {
        returnSuccessAfter(duration: 0.4, completion: completion, response: GetClubPlayersResponseBody(players: getPlayers()))
    }

    // MARK: GET /players/{playerID}
    override func player(playerID: String, completion: @escaping BetterpickAPIManager.Callback<Player>) {
        let player = Player(id: 0, name: "L. Messi", age: 35, photo: URL(string: "https://cdn.sofifa.com/players/158/023/20_120.png")!, nationality: "Argentina", overall: 94, club: "FC Barcelona", value: 95000000, wage: 540000, releaseClause: 9999, preferredFoot: "Left", skillMoves: 5, workRate: "Medium/Low", exactPosition: .CF, jerseyNumber: 10, height: "kek", weight: 9, crossing: 85, finishing: 98, headingAccuracy: 83, shortPassing: 90, volleys: 90, dribbling: 97, curve: 96, fkAccuracy: 95, longPassing: 90, ballControl: 98, acceleration: 93, sprintSpeed: 89, agility: 90, reactions: 91, balance: 90, shotPower: 88, jumping: 84, stamina: 80, strength: 85, longshots: 93, aggression: 84, interceptions: 85, positioning: 94, vision: 95, penalties: 94, composure: 98, marking: 93, standingTackle: 88, slidingTackle: 82, gkDiving: 46, gkHandling: 48, gkKicking: 60, gkPositioning: 44, gkReflexes: 41)
        returnSuccessAfter(duration: 0.2, completion: completion, response: player)
    }

    // MARK: GET /search?name=...
    override func search(name: String, completion: @escaping BetterpickAPIManager.Callback<GetSearchResponseBody>) {
        let searchResultPlayers = getPlayers(range: 0..<4)
        let searchResultClubs = teams.shuffled().dropLast(Int.random(in: 14...18))
        let searchResult = GetSearchResponseBody(players: searchResultPlayers, clubs: Array(searchResultClubs))
        returnSuccessAfter(duration: 0.25, completion: completion, response: searchResult)
    }

    override func players(filterData: PlayerFilterData, completion: @escaping BetterpickAPIManager.Callback<GetPlayersResponseBody>) {
        var players = getPlayers(range: 28..<34, ovrRange: filterData.ovrGreaterThanOrEqual...filterData.ovrLessThanOrEqual)
        let sortFn: ((Int, Int) -> Bool) = (filterData.sortOrder == .asc) ? (<) : (>)
        players.sort { sortFn($0.ovr, $1.ovr) }
        let result = GetPlayersResponseBody(players: players)
        returnSuccessAfter(completion: completion, response: result)
    }

    override func club(clubID: String, completion: @escaping BetterpickAPIManager.Callback<TeamPreview>) {
        returnSuccessAfter(completion: completion, response: TeamPreview(name: "FC Barcelona", logo: URL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png")!))
    }
}
