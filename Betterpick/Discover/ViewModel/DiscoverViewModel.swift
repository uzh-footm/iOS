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
    var currentSection: DiscoverSection { didSet { onViewModelUpdate?(currentSection) } }

    // MARK: Actions
    var onViewModelUpdate: ((DiscoverSection) -> Void)?

    // MARK: - Initialization
    init(initialSection: DiscoverSection = .teams) {
        self.currentSection = initialSection
    }

    // MARK: - Public
    public func update(section index: Int) {
        currentSection = DiscoverSection(rawValue: index) ?? .teams
    }

    public var title: String {
        return "Discover"
    }
}
