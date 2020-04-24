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
        case fetchingLeague
        case displaying(league: League)
    }

    // MARK: - Properties
    var state: ViewState = .initial {
        didSet { onStateUpdate(old: oldValue, new: state) }
    }

    // MARK: - Private
    private func onStateUpdate(old: ViewState, new: ViewState) {

    }

    // MARK: - Public
    public func fetchLeagues() {
        let league = League(name: "Bundesliga", leagueId: "1")
        // FIXME: Add API Manager calls
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.state = .displaying(leagues: [league], leagueData: .displaying(league: league))
        }
    }
}
