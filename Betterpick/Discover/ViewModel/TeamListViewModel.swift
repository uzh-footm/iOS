//
//  TeamListViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class TeamListViewModel {

    enum ViewState {
        /// Initial state of the view
        case initial
        /// Get all leagues
        case fetchingLeagues
        /// Display all leagues and a detail for one of them
        case displaying(leagues: [League], leagueData: LeagueDataState)
        case fetchingError(Error)
    }

    enum LeagueDataState {
        case fetching(league: League)
        case displaying(league: League)
    }

    // MARK: - Properties
    /// The view's state
    private (set) var state: ViewState = .initial {
        didSet { handleStateChange(old: oldValue, new: state) }
    }

    let apiManager: BetterpickAPIManager

    // MARK: Computed
    var isDisplayingLeagues: Bool {
        guard case .displaying = state else { return false }
        return true
    }

    // MARK: Actions
    var onStateUpdate: (() -> Void)?

    // MARK: - Initialization
    init(apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.apiManager = apiManager
    }

    // MARK: - Private
    // MARK: State
    private func handleStateChange(old: ViewState, new: ViewState) {
        switch (old, new) {
        case (.initial, .fetchingLeagues):
            fetchLeagues()
        case (_, .displaying(let leagues, leagueData: .fetching(let newLeague))):
            guard newLeague.teams == nil else {
                state = .displaying(leagues: leagues, leagueData: .displaying(league: newLeague))
                return
            }
            fetch(league: newLeague, leagues: leagues)
        default:
            break
        }
        // Notify the view
        onStateUpdate?()
    }

    private func fetchLeagues() {
        apiManager.leagues { [weak self] result in
            switch result {
            case .error(let error):
                self?.state = .fetchingError(error)
            case .success(let leaguesBody):
                guard let firstLeague = leaguesBody.leagues.first else {
                    // FIXME: Add proper errors
                    self?.state = .fetchingError(NSError(domain: "temp", code: 0, userInfo: nil))
                    return
                }
                self?.fetch(league: firstLeague, leagues: leaguesBody.leagues)
            }
        }
    }

    private func fetch(league: League, leagues: [League]) {
        apiManager.league(leagueID: league.leagueId) { [weak self] result in
            switch result {
            case .error(let error):
                self?.state = .fetchingError(error)
            case .success(let leagueBody):
                league.teams = leagueBody.teams
                self?.state = .displaying(leagues: leagues, leagueData: .displaying(league: league))
            }
        }
    }

    // MARK: - Public
    public func startFetchingAfterInitial() {
        state = .fetchingLeagues
    }

    public func fetchLeague(at row: Int) {
        guard case .displaying(let leagues, _) = state else { return }
        let newLeague = leagues[row]
        state = .displaying(leagues: leagues, leagueData: .fetching(league: newLeague))
    }

    public func numberOfTeams() -> Int {
        guard case .displaying(_, .displaying(let league)) = state else { return 0 }
        return league.teams?.count ?? 0
    }

    public func numberOfLeagues() -> Int {
        guard case .displaying(let leagues, _) = state else { return 0 }
        return leagues.count
    }

    public func league(at row: Int) -> League? {
        guard case .displaying(let leagues, _) = state else { return nil }
        return leagues[row]
    }

    public var currentLeague: League? {
        switch state {
        case .displaying(_, .displaying(let league)), .displaying(_, .fetching(let league)):
            return league
        default:
            return nil
        }
    }
}
