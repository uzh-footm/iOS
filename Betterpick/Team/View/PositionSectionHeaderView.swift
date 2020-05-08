//
//  PositionSectionHeaderView.swift
//  Betterpick
//
//  Created by David Bielik on 07/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PositionSectionHeaderView: CustomTableViewHeaderFooterView, Reusable {

    // MARK: - Properties
    let label = UILabel(style: .sectionTitle)
    let positionColoredView = UIView()

    private var positionColoredViewHeightConstraint: NSLayoutConstraint?

    static let reuseIdentifier: String = "SectionHeaderView"

    // MARK: - Private
    private func updateHeightConstraint() {
        let textStorage = NSTextStorage(string: text)
        let range = NSRangeFromString(text)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0

        layoutManager.addTextContainer(textContainer)

        var glyphRange = NSRange()
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

        let textHeight = boundingRect.height
        positionColoredViewHeightConstraint?.constant = textHeight
        layoutIfNeeded()
    }

    // MARK: - Inherited
    final override func setupSubviews() {
        add(subview: positionColoredView)
        positionColoredView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        positionColoredView.widthAnchor.constraint(equalToConstant: 6).isActive = true
        let heightConstraint = positionColoredView.heightAnchor.constraint(equalToConstant: .zero)
        heightConstraint.isActive = true
        positionColoredViewHeightConstraint = heightConstraint

        add(subview: label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: positionColoredView.trailingAnchor, constant: Size.standardMargin/4).isActive = true

        positionColoredView.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
    }

    // MARK: - Public
    public var text: String = "" {
        didSet {
            label.text = text
            updateHeightConstraint()
        }
    }

    public var positionColor: UIColor = .primary {
        didSet {
            positionColoredView.backgroundColor = positionColor
        }
    }
}
