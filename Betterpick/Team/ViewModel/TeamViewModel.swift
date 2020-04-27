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
                self?.team.squad = Team.createSquad(previews: clubBody.players)
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
    public func startInitialFetch() {
        state = .fetching
    }

    public func getSquad() -> Team.Squad? {
        guard case .displaying = state else { return nil }
        return team.squad
    }

    public func getPlayersAt(sectionIndex: Int) -> [PlayerPreview]? {
        guard let squad = getSquad() else { return nil }
        let position = PlayerPosition.allCases[sectionIndex]
        return squad[position]
    }

    public func numberOfPlayersForPosition(at sectionIndex: Int) -> Int {
        return getPlayersAt(sectionIndex: sectionIndex)?.count ?? 0
    }

    public func titleForPosition(at sectionIndex: Int) -> String? {
        return PlayerPosition.allCases[sectionIndex].rawValue.capitalizingFirstLetter()
    }

    public func player(at indexPath: IndexPath) -> PlayerPreview? {
        guard let positionPlayers = getPlayersAt(sectionIndex: indexPath.section) else { return nil }
        return positionPlayers[indexPath.row]
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
