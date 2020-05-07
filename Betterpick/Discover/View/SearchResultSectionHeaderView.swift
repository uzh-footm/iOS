//
//  SearchResultSectionHeaderView.swift
//  Betterpick
//
//  Created by David Bielik on 07/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SearchResultSectionHeaderView: SectionHeaderView {

    // MARK: - Properties
    let resultsCountLabel = UILabel(style: .secondary)

    // MARK: - Inherited
    override func setup() {
        add(subview: resultsCountLabel)
        resultsCountLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        resultsCountLabel.firstBaselineAnchor.constraint(equalTo: label.firstBaselineAnchor).isActive = true
        label.setContentHuggingPriority(.init(250), for: .horizontal)
        resultsCountLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        resultsCountLabel.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        let inBetweenLabelsConstraint = resultsCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: Size.standardMargin)
        inBetweenLabelsConstraint.priority = .init(255)
        inBetweenLabelsConstraint.isActive = true
    }

    // MARK: - Public
    public var results: Int = 0 {
        didSet {
            resultsCountLabel.text = "\(results) results"
        }
    }
}
