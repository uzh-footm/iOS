//
//  PlayerDetailViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class PlayerDetailViewModel: SimpleFetchingViewModel<Player> {

    // MARK: - Properties
    let playerPreview: PlayerPreview

    // MARK: - Initialization
    init(playerPreview: PlayerPreview, apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.playerPreview = playerPreview
        super.init(apiManager: apiManager)
    }

    // MARK: - Inherited
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<Player>) {
        apiManager.player(playerID: playerPreview.playerId, completion: completion)
    }
}
