//
//  TeamViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class TeamViewModel: FetchingViewModel<GetClubResponseBody, Team> {

    // MARK: - Properties
    let team: Team

    // MARK: - Initialization
    init(teamPreview: TeamPreview, apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.team = Team(from: teamPreview)
        super.init(apiManager: apiManager)
    }

    // MARK: - Inherited
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<GetClubResponseBody>) {
        apiManager.club(clubID: team.teamId, completion: completion)
    }

    override func responseBodyToModel(_ responseBody: GetClubResponseBody) -> Team? {
        team.squad = Team.createSquad(previews: responseBody.players)
        return team
    }

    // MARK: - Public
    public func getSquad() -> Team.Squad? {
        guard case .displaying = state else { return nil }
        return team.squad
    }

    public func getPlayersAt(sectionIndex: Int) -> [PlayerPreview]? {
        guard let squad = getSquad() else { return nil }
        return squad[sectionIndex].players
    }

    public func numberOfPlayersForPosition(at sectionIndex: Int) -> Int {
        return getPlayersAt(sectionIndex: sectionIndex)?.count ?? 0
    }

    public func titleForPosition(at sectionIndex: Int) -> String {
        guard let squad = getSquad() else { return "" }
        return squad[sectionIndex].position.rawValue.capitalizingFirstLetter()
    }

    public func player(at indexPath: IndexPath) -> PlayerPreview? {
        guard let positionPlayers = getPlayersAt(sectionIndex: indexPath.section) else { return nil }
        return positionPlayers[indexPath.row]
    }
}
