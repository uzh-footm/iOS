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
        League(id: "Bundesliga"),
        League(id: "2. Bundesliga"),
        League(id: "Premier League"),
        League(id: "EFL Championship"),
        League(id: "Swiss Super League"),
        League(id: "La Liga")
    ]

    let nationalities = [
        Nationality(name: "Germany", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/ba/Flag_of_Germany.svg")!),
        Nationality(name: "Slovakia", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/1920px-Flag_of_Slovakia.svg.png")!),
        Nationality(name: "Greece", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_Greece.svg")!),
        Nationality(name: "Argentina", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/1280px-Flag_of_Argentina.svg.png")!)
    ]
    
    let bundesligaTeamsRaw =
    """
    [{"id":"1. FC Nürnberg","logo":"https://cdn.sofifa.org/teams/2/light/171.png"},{"id":"1. FSV Mainz 05","logo":"https://cdn.sofifa.org/teams/2/light/169.png"},{"id":"Bayer 04 Leverkusen","logo":"https://cdn.sofifa.org/teams/2/light/32.png"},{"id":"Borussia Dortmund","logo":"https://cdn.sofifa.org/teams/2/light/22.png"},{"id":"Borussia Mönchengladbach","logo":"https://cdn.sofifa.org/teams/2/light/23.png"},{"id":"Eintracht Frankfurt","logo":"https://cdn.sofifa.org/teams/2/light/1824.png"},{"id":"FC Augsburg","logo":"https://cdn.sofifa.org/teams/2/light/100409.png"},{"id":"FC Bayern München","logo":"https://cdn.sofifa.org/teams/2/light/21.png"},{"id":"FC Schalke 04","logo":"https://cdn.sofifa.org/teams/2/light/34.png"},{"id":"Fortuna Düsseldorf","logo":"https://cdn.sofifa.org/teams/2/light/110636.png"},{"id":"Hannover 96","logo":"https://cdn.sofifa.org/teams/2/light/485.png"},{"id":"Hertha BSC","logo":"https://cdn.sofifa.org/teams/2/light/166.png"},{"id":"RB Leipzig","logo":"https://cdn.sofifa.org/teams/2/light/112172.png"},{"id":"SC Freiburg","logo":"https://cdn.sofifa.org/teams/2/light/25.png"},{"id":"SV Werder Bremen","logo":"https://cdn.sofifa.org/teams/2/light/38.png"},{"id":"TSG 1899 Hoffenheim","logo":"https://cdn.sofifa.org/teams/2/light/10029.png"},{"id":"VfB Stuttgart","logo":"https://cdn.sofifa.org/teams/2/light/36.png"},{"id":"VfL Wolfsburg","logo":"https://cdn.sofifa.org/teams/2/light/175.png"}]
    """
    
    lazy var teams: [TeamPreview] = {
        guard let data = bundesligaTeamsRaw.data(using: .utf8), let teams = try? JSONDecoder().decode([TeamPreview].self, from: data) else { return [] }
        return teams
    }()
    
    let fcbPlayersRaw =
    """
    [{"id":188545,"name":"R. Lewandowski","age":29,"photo":"https://cdn.sofifa.org/players/4/19/188545.png","nationality":"Poland","overall":90,"club":"FC Bayern München","value":77000000,"wage":205000,"releaseClause":127100000,"preferredFoot":"Right","skillMoves":4,"workRate":"High","position":"ST","jerseyNumber":9,"height":"6'0","weight":176},{"id":167495,"name":"M. Neuer","age":32,"photo":"https://cdn.sofifa.org/players/4/19/167495.png","nationality":"Germany","overall":89,"club":"FC Bayern München","value":38000000,"wage":130000,"releaseClause":62700000,"preferredFoot":"Right","skillMoves":1,"workRate":"Medium","position":"GK","jerseyNumber":1,"height":"6'4","weight":203},{"id":198710,"name":"J. Rodríguez","age":26,"photo":"https://cdn.sofifa.org/players/4/19/198710.png","nationality":"Colombia","overall":88,"club":"FC Bayern München","value":69500000,"wage":315000,"releaseClause":0,"preferredFoot":"Left","skillMoves":4,"workRate":"Medium","position":"LAM","jerseyNumber":10,"height":"5'11","weight":172},{"id":178603,"name":"M. Hummels","age":29,"photo":"https://cdn.sofifa.org/players/4/19/178603.png","nationality":"Germany","overall":88,"club":"FC Bayern München","value":46000000,"wage":160000,"releaseClause":75900000,"preferredFoot":"Right","skillMoves":3,"workRate":"High","position":"LCB","jerseyNumber":5,"height":"6'3","weight":203},{"id":189596,"name":"T. Müller","age":28,"photo":"https://cdn.sofifa.org/players/4/19/189596.png","nationality":"Germany","overall":86,"club":"FC Bayern München","value":45000000,"wage":135000,"releaseClause":74300000,"preferredFoot":"Right","skillMoves":3,"workRate":"High","position":"CAM","jerseyNumber":13,"height":"6'1","weight":165},{"id":189509,"name":"Thiago","age":27,"photo":"https://cdn.sofifa.org/players/4/19/189509.png","nationality":"Spain","overall":86,"club":"FC Bayern München","value":45500000,"wage":130000,"releaseClause":75100000,"preferredFoot":"Right","skillMoves":5,"workRate":"Medium","position":"CM","jerseyNumber":19,"height":"5'9","weight":154},{"id":212622,"name":"J. Kimmich","age":23,"photo":"https://cdn.sofifa.org/players/4/19/212622.png","nationality":"Germany","overall":85,"club":"FC Bayern München","value":40500000,"wage":92000,"releaseClause":69900000,"preferredFoot":"Right","skillMoves":3,"workRate":"High","position":"RCM","jerseyNumber":18,"height":"5'9","weight":154},{"id":197445,"name":"D. Alaba","age":26,"photo":"https://cdn.sofifa.org/players/4/19/197445.png","nationality":"Austria","overall":85,"club":"FC Bayern München","value":38000000,"wage":110000,"releaseClause":65600000,"preferredFoot":"Left","skillMoves":3,"workRate":"High","position":"LB","jerseyNumber":8,"height":"5'11","weight":168},{"id":183907,"name":"J. Boateng","age":29,"photo":"https://cdn.sofifa.org/players/4/19/183907.png","nationality":"Germany","overall":85,"club":"FC Bayern München","value":30000000,"wage":115000,"releaseClause":49500000,"preferredFoot":"Right","skillMoves":2,"workRate":"Medium","position":"RCB","jerseyNumber":17,"height":"6'4","weight":198},{"id":212190,"name":"N. Süle","age":22,"photo":"https://cdn.sofifa.org/players/4/19/212190.png","nationality":"Germany","overall":84,"club":"FC Bayern München","value":36500000,"wage":84000,"releaseClause":67500000,"preferredFoot":"Right","skillMoves":2,"workRate":"Medium","position":"CB","jerseyNumber":15,"height":"6'5","weight":214},{"id":9014,"name":"A. Robben","age":34,"photo":"https://cdn.sofifa.org/players/4/19/9014.png","nationality":"Netherlands","overall":84,"club":"FC Bayern München","value":15500000,"wage":110000,"releaseClause":25600000,"preferredFoot":"Left","skillMoves":4,"workRate":"High","position":"RM","jerseyNumber":10,"height":"5'11","weight":176},{"id":219683,"name":"C. Tolisso","age":23,"photo":"https://cdn.sofifa.org/players/4/19/219683.png","nationality":"France","overall":83,"club":"FC Bayern München","value":34000000,"wage":85000,"releaseClause":58700000,"preferredFoot":"Right","skillMoves":3,"workRate":"High","position":"CM","jerseyNumber":24,"height":"5'11","weight":179},{"id":213345,"name":"K. Coman","age":22,"photo":"https://cdn.sofifa.org/players/4/19/213345.png","nationality":"France","overall":83,"club":"FC Bayern München","value":34000000,"wage":85000,"releaseClause":58700000,"preferredFoot":"Right","skillMoves":5,"workRate":"Medium","position":"LM","jerseyNumber":29,"height":"5'10","weight":157},{"id":209658,"name":"L. Goretzka","age":23,"photo":"https://cdn.sofifa.org/players/4/19/209658.png","nationality":"Germany","overall":83,"club":"FC Bayern München","value":34000000,"wage":85000,"releaseClause":58700000,"preferredFoot":"Right","skillMoves":3,"workRate":"High","position":"CM","jerseyNumber":14,"height":"6'2","weight":174},{"id":206113,"name":"S. Gnabry","age":22,"photo":"https://cdn.sofifa.org/players/4/19/206113.png","nationality":"Germany","overall":83,"club":"FC Bayern München","value":34500000,"wage":85000,"releaseClause":59500000,"preferredFoot":"Right","skillMoves":4,"workRate":"High","position":"ST","jerseyNumber":6,"height":"5'9","weight":165},{"id":177610,"name":"Javi Martínez","age":29,"photo":"https://cdn.sofifa.org/players/4/19/177610.png","nationality":"Spain","overall":83,"club":"FC Bayern München","value":20000000,"wage":94000,"releaseClause":33000000,"preferredFoot":"Right","skillMoves":2,"workRate":"Medium","position":"CDM","jerseyNumber":8,"height":"6'4","weight":190},{"id":156616,"name":"F. Ribéry","age":35,"photo":"https://cdn.sofifa.org/players/4/19/156616.png","nationality":"France","overall":83,"club":"FC Bayern München","value":11500000,"wage":72000,"releaseClause":19000000,"preferredFoot":"Right","skillMoves":5,"workRate":"Medium","position":"LM","jerseyNumber":7,"height":"5'7","weight":159},{"id":186569,"name":"S. Ulreich","age":29,"photo":"https://cdn.sofifa.org/players/4/19/186569.png","nationality":"Germany","overall":80,"club":"FC Bayern München","value":10000000,"wage":61000,"releaseClause":16500000,"preferredFoot":"Right","skillMoves":1,"workRate":"Medium","position":"GK","jerseyNumber":26,"height":"6'4","weight":185},{"id":168607,"name":"Rafinha","age":32,"photo":"https://cdn.sofifa.org/players/4/19/168607.png","nationality":"Brazil","overall":76,"club":"FC Bayern München","value":4300000,"wage":53000,"releaseClause":7000000,"preferredFoot":"Right","skillMoves":3,"workRate":"Medium","position":"RB","jerseyNumber":13,"height":"5'8","weight":150},{"id":230767,"name":"Renato Sanches","age":20,"photo":"https://cdn.sofifa.org/players/4/19/230767.png","nationality":"Portugal","overall":75,"club":"FC Bayern München","value":10000000,"wage":41000,"releaseClause":18500000,"preferredFoot":"Right","skillMoves":3,"workRate":"High","position":"CM","jerseyNumber":8,"height":"5'9","weight":154},{"id":235266,"name":"C. Früchtl","age":18,"photo":"https://cdn.sofifa.org/players/4/19/235266.png","nationality":"Germany","overall":65,"club":"FC Bayern München","value":1000000,"wage":3000,"releaseClause":2700000,"preferredFoot":"Left","skillMoves":1,"workRate":"Medium","position":"GK","jerseyNumber":36,"height":"6'4","weight":157},{"id":243275,"name":"L. Mai","age":18,"photo":"https://cdn.sofifa.org/players/4/19/243275.png","nationality":"Germany","overall":64,"club":"FC Bayern München","value":850000,"wage":5000,"releaseClause":2300000,"preferredFoot":"Right","skillMoves":2,"workRate":"Medium","position":"CB","jerseyNumber":15,"height":"6'3","weight":194},{"id":244024,"name":"O. Batista Meier","age":17,"photo":"https://cdn.sofifa.org/players/4/19/244024.png","nationality":"Germany","overall":63,"club":"FC Bayern München","value":725000,"wage":5000,"releaseClause":1900000,"preferredFoot":"Right","skillMoves":3,"workRate":"Medium","position":"LM","jerseyNumber":41,"height":"5'10","weight":132},{"id":243357,"name":"F. Evina","age":17,"photo":"https://cdn.sofifa.org/players/4/19/243357.png","nationality":"Germany","overall":63,"club":"FC Bayern München","value":725000,"wage":5000,"releaseClause":1600000,"preferredFoot":"Right","skillMoves":3,"workRate":"Medium","position":"LM","jerseyNumber":43,"height":"5'10","weight":161},{"id":242980,"name":"M. Shabani","age":19,"photo":"https://cdn.sofifa.org/players/4/19/242980.png","nationality":"Germany","overall":62,"club":"FC Bayern München","value":575000,"wage":5000,"releaseClause":1300000,"preferredFoot":"Right","skillMoves":3,"workRate":"Medium","position":"CAM","jerseyNumber":16,"height":"6'1","weight":159},{"id":245100,"name":"M. Awoudja","age":20,"photo":"https://cdn.sofifa.org/players/4/19/245100.png","nationality":"Germany","overall":61,"club":"FC Bayern München","value":375000,"wage":6000,"releaseClause":694000,"preferredFoot":"Right","skillMoves":2,"workRate":"Medium","position":"CB","jerseyNumber":45,"height":"6'2","weight":190},{"id":246127,"name":"P. Will","age":19,"photo":"https://cdn.sofifa.org/players/4/19/246127.png","nationality":"Germany","overall":61,"club":"FC Bayern München","value":525000,"wage":5000,"releaseClause":1200000,"preferredFoot":"Left","skillMoves":3,"workRate":"Medium","position":"CM","jerseyNumber":28,"height":"6'1","weight":170},{"id":243514,"name":"J. Meier","age":18,"photo":"https://cdn.sofifa.org/players/4/19/243514.png","nationality":"Germany","overall":59,"club":"FC Bayern München","value":290000,"wage":3000,"releaseClause":660000,"preferredFoot":"Left","skillMoves":2,"workRate":"Medium","position":"LB","jerseyNumber":23,"height":"5'10","weight":172},{"id":241859,"name":"R. Hoffmann","age":19,"photo":"https://cdn.sofifa.org/players/4/19/241859.png","nationality":"Germany","overall":56,"club":"FC Bayern München","value":160000,"wage":2000,"releaseClause":364000,"preferredFoot":"Right","skillMoves":1,"workRate":"Medium","position":"GK","jerseyNumber":39,"height":"6'4","weight":185}]
    """
    
    lazy var fcbPlayers: [PlayerPreview] = {
        guard let data = fcbPlayersRaw.data(using: .utf8), let players = try? JSONDecoder().decode([PlayerPreview].self, from: data) else { return [] }
        return players
    }()

    // MARK: - Mock Helpers
    private func returnSuccessAfter<Response: Decodable>(duration: TimeInterval = 0.2, completion: @escaping Callback<Response>, response: Response) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion(.success(response))
        }
    }

    private func getPlayers(range: Range<Int> = 28..<34, ovrRange: ClosedRange<Int>? = nil) -> [PlayerPreview] {
        let photos = [
            "https://cdn.sofifa.org/players/4/19/9014.png",
            "https://cdn.sofifa.org/players/4/19/164240.png",
            "https://cdn.sofifa.org/players/4/19/239085.png"
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
            let preview = PlayerPreview(id: index, name: "\(randomString(length: Int.random(in: 3..<12))) \(randomString(length: Int.random(in: 3..<12)))", photo: URL(string: photos.shuffled().first!)!, age: Int.random(in: 18..<38), jerseyNumber: Int.random(in: 1..<40), position: randomPosition, nationality: nationalities.randomElement()!.name, overall: ovr, club: teams.randomElement()!.name)
            playerPreviews.append(preview)
        }
        return playerPreviews
    }

    // MARK: - Inherited
    // MARK: GET /leagues
    override func leagues(completion: @escaping BetterpickAPIManager.Callback<GetLeaguesResponseBody>) {
        returnSuccessAfter(duration: 0.2, completion: completion, response: leagues)
    }

    // MARK: GET /nationalities
    override func nationalities(completion: @escaping BetterpickAPIManager.Callback<GetNationalitiesBody>) {
        returnSuccessAfter(completion: completion, response: nationalities)
    }

    // MARK: GET /leagues/{leagueID}
    override func league(leagueID: String, completion: @escaping BetterpickAPIManager.Callback<GetLeagueResponseBody>) {

        returnSuccessAfter(duration: 0.3, completion: completion, response: teams)
    }

    // Generating Random String
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    // MARK: GET /players/clubs/{clubID}
    override func clubPlayers(clubID: String, completion: @escaping Callback<GetClubPlayersResponseBody>) {
        returnSuccessAfter(duration: 0.4, completion: completion, response: fcbPlayers)
    }

    // MARK: GET /players/{playerID}
    override func player(playerID: String, completion: @escaping BetterpickAPIManager.Callback<Player>) {
        let player = Player(id: 0, name: "L. Messi", age: 35, photo: URL(string: "https://cdn.sofifa.com/players/158/023/20_120.png")!, nationality: "Argentina", overall: 94, club: "FC Barcelona", value: 95000000, wage: 540000, releaseClause: 9999, preferredFoot: "Left", skillMoves: 5, workRate: "Medium/Low", position: .CF, jerseyNumber: 10, height: "kek", weight: 9, crossing: 85, finishing: 98, headingAccuracy: 83, shortPassing: 90, volleys: 90, dribbling: 97, curve: 96, fkAccuracy: 95, longPassing: 90, ballControl: 98, acceleration: 93, sprintSpeed: 89, agility: 90, reactions: 91, balance: 90, shotPower: 88, jumping: 84, stamina: 80, strength: 85, longshots: 93, aggression: 84, interceptions: 85, positioning: 94, vision: 95, penalties: 94, composure: 98, marking: 93, standingTackle: 88, slidingTackle: 82, gkDiving: 46, gkHandling: 48, gkKicking: 60, gkPositioning: 44, gkReflexes: 41)
        returnSuccessAfter(duration: 0.2, completion: completion, response: player)
    }

    // MARK: GET /search?name=...
    override func players(filterData: PlayerFilterData, completion: @escaping BetterpickAPIManager.Callback<GetPlayersResponseBody>) {
        var players = getPlayers(range: 28..<34, ovrRange: filterData.ovrGreaterThanOrEqual...filterData.ovrLessThanOrEqual)
        let sortFn: ((Int, Int) -> Bool) = (filterData.sortOrder == .asc) ? (<) : (>)
        players.sort { sortFn($0.overall, $1.overall) }
        let result = players
        returnSuccessAfter(completion: completion, response: result)
    }
    
    override func searchClubs(name: String, completion: @escaping BetterpickAPIManager.Callback<GetClubsSearchResponseBody>) {
        let searchResultClubs = teams.shuffled().dropLast(Int.random(in: 14...18))
        returnSuccessAfter(completion: completion, response: Array(searchResultClubs))
    }
    
    override func searchPlayers(name: String, completion: @escaping BetterpickAPIManager.Callback<GetPlayersSearchResponseBody>) {
        let searchResultPlayers = getPlayers(range: 0..<4)
        returnSuccessAfter(duration: 0.25, completion: completion, response: searchResultPlayers)
    }

    override func club(clubID: String, completion: @escaping BetterpickAPIManager.Callback<TeamPreview>) {
        returnSuccessAfter(completion: completion, response: TeamPreview(id: "FC Barcelona", logo: URL(string: "https://cdn.sofifa.org/teams/2/light/241.png")!))
    }
}
