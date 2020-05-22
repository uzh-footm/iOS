//
//  SearchViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class SearchViewModel {

    // MARK: - Properties
    let apiManager: BetterpickAPIManager
    var searchText: String = ""
    var searchResult: SearchResult? { didSet { onSearchResultUpdate?() } }

    // MARK: Actions
    var onSearchResultUpdate: (() -> Void)?

    // MARK: - Initialization
    init(apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.apiManager = apiManager
    }

    // MARK: - Public
    func searchPlaceholderText() -> String {
        return "e.g. Messi, Manchester ..."
    }

    func search() {
        // Don't seearch if the text is empty
        guard !searchText.isEmpty else { return }
        let searchTextBeforeRequests = searchText
        let requests = DispatchGroup()
        var players: [PlayerPreview]?
        var clubs: [TeamPreview]?
        var playersError: Error?
        var clubsError: Error?
        
        requests.enter()
        apiManager.searchPlayers(name: searchText) { result in
            defer { requests.leave() }
            switch result {
            case .error(let error, _):
                playersError = error
            case .success(let playersBody):
                players = playersBody
            }
        }

        requests.enter()
        apiManager.searchClubs(name: searchText) { result in
            defer { requests.leave() }
            switch result {
            case .error(let error, _):
                clubsError = error
            case .success(let clubsBody):
                clubs = clubsBody
            }
        }

        requests.notify(queue: .global(qos: .default)) { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self, strongSelf.searchText == searchTextBeforeRequests else { return }
                guard let players = players else {
                    if let error = playersError {
                        // FIXME: do smth
                        strongSelf.searchResult = SearchResult(players: [], clubs: [])
                    }
                    return
                }
                guard let clubs = clubs else {
                    if let error = clubsError {
                        // FIXME: do smth
                        strongSelf.searchResult = SearchResult(players: [], clubs: [])
                    }
                    return
                }
                strongSelf.searchResult = SearchResult(players: players, clubs: clubs)
            }
        }
    }

    func numberOfSections() -> Int {
        guard searchResult != nil else { return 0 }
        return 2
    }

    func playerPreview(at row: Int) -> PlayerPreview? {
        guard let searchResult = searchResult else { return nil }
        return searchResult.players[row]
    }

    func clubPreview(at row: Int) -> TeamPreview? {
        guard let searchResult = searchResult else { return nil }
        return searchResult.clubs[row]
    }

    func previews(at section: Int) -> [Decodable]? {
        guard let searchResult = searchResult else { return nil }
        return searchResult.previews(at: section)
    }

    func previews(at indexPath: IndexPath) -> Decodable? {
        return previews(at: indexPath.section)?[indexPath.row]
    }

    func titleFor(section: Int) -> String {
        guard let searchResult = searchResult else { return "" }
        return searchResult.title(at: section)
    }
}
