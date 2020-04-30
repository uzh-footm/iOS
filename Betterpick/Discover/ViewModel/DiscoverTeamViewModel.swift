//
//  DiscoverTeamViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class DiscoverTeamViewModel: FetchingViewModel<GetLeagueResponseBody, League> {

    // MARK: - Properties
    let leagues: [League]
    var selectedLeague: League?

    // MARK: - Initialization
    init(leagues: [League], apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.leagues = leagues
        selectedLeague = leagues.first
        super.init(apiManager: apiManager)
    }

    // MARK: - Private
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<GetLeagueResponseBody>) {
        guard let selected = selectedLeague else { return }
        apiManager.league(leagueID: selected.leagueId, completion: completion)
    }

    override func responseBodyToModel(_ responseBody: GetLeagueResponseBody) -> League? {
        guard let selected = selectedLeague else { return nil }
        selected.teams = responseBody.teams
        return selected
    }

    // MARK: - Public
    public func fetchLeague(at row: Int) {
        if case .fetching = state { return }
        selectedLeague = league(at: row)
        start()
    }

    public func numberOfTeams() -> Int {
        return currentLeague?.teams?.count ?? 0
    }

    public func numberOfLeagues() -> Int {
        return leagues.count
    }

    public func league(at row: Int) -> League? {
        return leagues[row]
    }

    public var currentLeague: League? {
        switch state {
        case .displaying(let league): return league
        default: return nil
        }
    }
}
