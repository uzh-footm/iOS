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

    // MARK: Public
    public var text: String = "" {
        didSet {
            label.text = text
        }
    }

    public var labelStyle: UILabel.Style = .sectionTitle {
        didSet {
            label.set(style: labelStyle)
        }
    }

    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        privateSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateSetup()
    }

    // MARK: - Private
    private func privateSetup() {
        setupSubviews()
        setup()
    }

    private func setupSubviews() {
        add(subview: label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
    }

    // MARK: - Open
    /// Override this function to provide customization (e.g. adding subviews / constraints) for this View
    open func setup() {

    }
}
