//
//  SectionHeaderView.swift
//  Betterpick
//
//  Created by David Bielik on 07/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView, Reusable {

    // MARK: - Properties
    let label = UILabel(style: .sectionTitle)

    static let reuseIdentifier: String = "SectionHeaderView"

    var text: String = "" {
        didSet {
            label.text = text
        }
    }

    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    // MARK: - Private
    private func setupSubviews() {
        add(subview: label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
    }
}
