//
//  RangeSliderTableViewCell.swift
//  Betterpick
//
//  Created by David Bielik on 02/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class RangeSliderTableViewCell: UITableViewCell {

    // MARK: - Properties
    // MARK: UI
    let valueInfoLabel = UILabel(style: .cellTitle)

    let valueLabel = UILabel(style: .secondary)

    let rangeSlider = RangeSlider()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private
    private func setup() {
        selectionStyle = .none

        setupSubviews()
    }

    // Autolayout code
    private func setupSubviews() {
        // Labels
        contentView.add(subview: valueInfoLabel)
        valueInfoLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        valueInfoLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true

        contentView.add(subview: valueLabel)
        valueLabel.centerYAnchor.constraint(equalTo: valueInfoLabel.centerYAnchor).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true

        valueInfoLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        valueLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        valueInfoLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -Size.standardMargin).isActive = true

        // Range Slider
        contentView.add(subview: rangeSlider)
        rangeSlider.embedSidesInMargins(in: contentView)
        rangeSlider.topAnchor.constraint(equalTo: valueInfoLabel.bottomAnchor, constant: Size.standardMargin).isActive = true
        rangeSlider.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
