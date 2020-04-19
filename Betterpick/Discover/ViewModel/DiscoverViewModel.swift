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
    // MARK: Model
    let sections = DiscoverSection.allCases
    let currentSection: DiscoverSection

    // MARK: - Initialization
    init(initialSection: DiscoverSection = .teams) {
        self.currentSection = initialSection
    }
}
