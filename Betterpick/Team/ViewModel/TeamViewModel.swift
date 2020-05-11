//
//  TeamViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class TeamViewModel: FetchingViewModel<GetClubPlayersResponseBody, Team> {

    // MARK: - Properties
    let team: Team

    // MARK: - Initialization
    init(teamPreview: TeamPreview, apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.team = Team(from: teamPreview)
        super.init(apiManager: apiManager)
    }

    // MARK: - Inherited
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<GetClubPlayersResponseBody>) {
        apiManager.clubPlayers(clubID: team.name, completion: completion)
    }

    override func responseBodyToModel(_ responseBody: GetClubPlayersResponseBody) -> Team? {
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

    public func position(at sectionIndex: Int) -> PlayerPosition? {
        guard let squad = getSquad() else { return nil }
        return squad[sectionIndex].position
    }

    public func titleFor(position: PlayerPosition) -> String {
        var positionText = position.positionText
        if let squad = getSquad(), let players = squad.first(where: { $0.position == position })?.players, players.count > 1 {
            positionText += "s"
        }
        return positionText.uppercased()
    }

    public func player(at indexPath: IndexPath) -> PlayerPreview? {
        guard let positionPlayers = getPlayersAt(sectionIndex: indexPath.section) else { return nil }
        return positionPlayers[indexPath.row]
    }
}
