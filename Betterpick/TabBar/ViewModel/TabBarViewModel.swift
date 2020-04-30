//
//  TabBarViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class TabBarViewModel {

    // MARK: - Properties
    let leagueAndNationalityData: LeagueAndNationalityData
    // MARK: Model
    private(set) var currentTab: Tab? = nil {
        didSet {
            guard let tab = currentTab else { return }
            guard oldValue != tab else {
                onTabReselect?(tab)
                return
            }
            onTabChange?(tab)
        }
    }

    var tabs: Tabs {
        return Tab.allCases
    }

    // MARK: Callbacks
    var onTabChange: ((Tab) -> Void)?
    var onTabReselect: ((Tab) -> Void)?

    // MARK: - Initialization
    init(data: LeagueAndNationalityData) {
        self.leagueAndNationalityData = data
    }

    // MARK: - Internal
    /// Tab setter for clarity
    func updateTab(to tab: Tab) {
        currentTab = tab
    }
}
