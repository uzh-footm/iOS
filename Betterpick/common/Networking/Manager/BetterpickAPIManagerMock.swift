//
//  BetterpickAPIManagerMock.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class BetterpickAPIManagerMock: BetterpickAPIManager {

    // MARK: - Mock Helpers
    fileprivate func returnSuccessAfter<Response: Decodable>(duration: TimeInterval = 1.5, completion: @escaping Callback<Response>, response: Response) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion(.success(response))
        }
    }

    let leagues: [League] = [
        League(name: "Bundesliga", leagueId: "0"),
        League(name: "2. Bundesliga", leagueId: "1"),
        League(name: "Premier League", leagueId: "2"),
        League(name: "EFL Championship", leagueId: "3"),
        League(name: "Swiss Super League", leagueId: "4"),
        League(name: "La Liga", leagueId: "5")
    ]

    // MARK: - Inherited
    override func leagues(completion: @escaping BetterpickAPIManager.Callback<GetLeaguesResponseBody>) {
        returnSuccessAfter(duration: 1, completion: completion, response: GetLeaguesResponseBody(leagues: leagues))
    }

    override func league(leagueID: String, completion: @escaping BetterpickAPIManager.Callback<GetLeagueResponseBody>) {
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
        returnSuccessAfter(duration: 0.5, completion: completion, response: GetLeagueResponseBody(teams: teams))
    }
}
