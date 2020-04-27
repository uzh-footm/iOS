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
        let currentSearchText = searchText
        apiManager.search(name: searchText) { [weak self] result in
            guard let strongSelf = self, strongSelf.searchText == currentSearchText else { return }
            guard case .success(let searchResponse) = result else { return }
            strongSelf.searchResult = SearchResult(getSearchResponse: searchResponse)
        }
    }

    func numberOfSections() -> Int {
        guard searchResult != nil else { return 0 }
        return 2
    }

    func playerPreview(at row: Int) -> PlayerPreview? {
        guard let searchResult = searchResult, let players = searchResult.players else { return nil }
        return players[row]
    }

    func clubPreview(at row: Int) -> TeamPreview? {
        guard let searchResult = searchResult, let clubs = searchResult.clubs else { return nil }
        return clubs[row]
    }

    func previews(at section: Int) -> [Decodable]? {
        guard let searchResult = searchResult else { return nil }
        return searchResult.previews(at: section)
    }

    func previews(at indexPath: IndexPath) -> Decodable? {
        return previews(at: indexPath.section)?[indexPath.row]
    }

    func titleFor(section: Int) -> String? {
        guard let searchResult = searchResult else { return nil }
        if searchResult.previews(at: section).isEmpty {
            return nil
        } else {
            return searchResult.title(at: section)
        }
    }
}
