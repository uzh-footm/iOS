//
//  PlayerDetailViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation


class PlayerDetailViewModel {

    enum ViewState {
        case fetching
        case displaying(player: Player)
        case error(Error)
    }

    // MARK: - Properties
    let playerPreview: PlayerPreview
    let apiManager: BetterpickAPIManager

    // MARK: ViewState
    private(set) var state: ViewState = .fetching {
        didSet { handleStateChange(old: oldValue, new: state) }
    }

    var onStateUpdate: (() -> Void)?

    // MARK: - Initialization
    init(playerPreview: PlayerPreview, apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.playerPreview = playerPreview
        self.apiManager = apiManager
    }

    // MARK: - Private
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

    private func startFetchingTeam() {
        apiManager.player(playerID: playerPreview.playerId) { [weak self] result in
            switch result {
            case .error(let error):
                self?.state = .error(error)
            case .success(let player):
                self?.state = .displaying(player: player)
            }
        }
    }

    // MARK: - Public
    public func fetchPlayerDetails() {
        state = .fetching
    }
}
