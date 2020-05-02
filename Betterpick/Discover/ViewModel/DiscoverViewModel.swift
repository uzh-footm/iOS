//
//  DiscoverViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class DiscoverViewModel {

    // MARK: - Properties
    let leagueAndNationalityData: LeagueAndNationalityData
    private static let initialSection: DiscoverSection = .players

    // MARK: Model
    let sections = DiscoverSection.allCases
    var currentSection: DiscoverSection = DiscoverViewModel.initialSection {
        didSet {
            onSectionUpdate?(currentSection)
        }
    }

    // MARK: Actions
    var onSectionUpdate: ((DiscoverSection) -> Void)?

    // MARK: - Initialization
    init(leagueAndNationalityData: LeagueAndNationalityData) {
        self.leagueAndNationalityData = leagueAndNationalityData
    }

    // MARK: - Public
    public func update(section index: Int) {
        currentSection = DiscoverSection(rawValue: index) ?? DiscoverViewModel.initialSection
    }

    public var title: String {
        return "Discover"
    }
}
