//
//  SearchResult.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

struct SearchResult {
    // MARK: - Properties
    let players: [PlayerPreview]?
    let clubs: [TeamPreview]?

    /// The data about the sections, namely the order in which they are displayed
    static let sectionMetadata: [(keyPath: PartialKeyPath<SearchResult>, title: String)] = [
        (\SearchResult.clubs, "Clubs"),
        (\SearchResult.players, "Players")
    ]

    // MARK: - Initialization
    init(getSearchResponse: GetSearchResponseBody) {
        self.players = getSearchResponse.players
        self.clubs = getSearchResponse.clubs
    }

    /// - returns: the number of result sections. Possible values are: { 0, 1, 2 }
    func numberOfResults() -> Int {
        var count = 0
        if clubs != nil {
            count += 1
        }
        if players != nil {
            count += 1
        }
        return count
    }

    // MARK: - Public
    func title(at section: Int) -> String {
        return SearchResult.sectionMetadata[section].title
    }

    func previews(at section: Int) -> [Decodable] {
        return self[keyPath: SearchResult.sectionMetadata[section].keyPath] as? [Decodable] ?? []
    }
}
