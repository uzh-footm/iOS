//
//  TeamViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class TeamViewModel {

    enum ViewState {
        case fetching
        case displaying
        case error(Error)
    }

    // MARK: - Properties
    let team: Team
    let apiManager: BetterpickAPIManager

    // MARK: ViewState
    private(set) var state: ViewState = .fetching {
        didSet { handleStateChange(old: oldValue, new: state) }
    }

    // MARK: Actions
    var onStateUpdate: (() -> Void)?

    // MARK: - Initialization
    init(teamPreview: TeamPreview, apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.team = Team(from: teamPreview)
        self.apiManager = apiManager
    }

    // MARK: - Private
    private func startFetchingTeam() {
        apiManager.club(clubID: team.teamId) { [weak self] result in
            switch result {
            case .error(let error):
                self?.state = .error(error)
            case .success(let clubBody):
                self?.team.playersPreview = clubBody.players
                self?.state = .displaying
            }
        }
    }

    private func handleStateChange(old: ViewState, new: ViewState) {
        switch (old, new) {
        case (.fetching, .fetching):
            // Initial fetch
            startFetchingTeam()
        default:
            break
        }
        // Notify the view
        onStateUpdate?()
    }

    // MARK: - Public
    public func fetchTeam() {
        state = .fetching
    }
}
