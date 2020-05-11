//
//  PositionSectionHeaderView.swift
//  Betterpick
//
//  Created by David Bielik on 07/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {

    // MARK: - Overrides
    // MARK: Properties
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += edgeInsets.top + edgeInsets.bottom
        size.width += edgeInsets.left + edgeInsets.right
        return size
    }

    // MARK: Functions
    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: edgeInsets)
        super.drawText(in: newRect)
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRectBounds = bounds.inset(by: edgeInsets)
        return super.textRect(forBounds: textRectBounds, limitedToNumberOfLines: numberOfLines)
    }

    // MARK: - Public
    public var edgeInsets = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
}

class ColoredPositionLabel: PaddedLabel {

    // MARK: - Properties
    static let coloredViewWidth: CGFloat = 6

    // MARK: - Overrides
    private var coloredRectangleHeight: CGFloat? {
        didSet {
            setNeedsDisplay()
        }
    }

    override var font: UIFont! {
        didSet {
            guard font != nil else { return }
            // Set the colored rectangle height whenever the font changes
            coloredRectangleHeight = font.capHeight + 2
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Functions
    override func draw(_ rect: CGRect) {
        // Make sure to call super.draw before returning
        defer { super.draw(rect) }
        // Get the context
        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        // Compute the colored rect
        let coloredRectHeight = coloredRectangleHeight ?? 0
        let coloredRectOrigin = CGPoint(x: 0, y: (rect.height - coloredRectHeight) / 2)
        let coloredRect = CGRect(origin: coloredRectOrigin, size: CGSize(width: ColoredPositionLabel.coloredViewWidth, height: coloredRectHeight))
        let coloredRectPath = UIBezierPath(rect: coloredRect)

        // Fill
        ctx.setFillColor(coloredRectangleColor.cgColor)
        ctx.addPath(coloredRectPath.cgPath)
        ctx.fillPath()
    }

    // MARK: - Private
    private func setup() {
        edgeInsets = UIEdgeInsets(top: 0, left: ColoredPositionLabel.coloredViewWidth + Size.standardMargin/4, bottom: 0, right: 0)
    }

    // MARK: - Public
    public var coloredRectangleColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }

    public func configure(from position: PlayerPosition) {
        coloredRectangleColor = position.color
        text = position.positionText
    }

    public func configure(from exactPosition: ExactPlayerPosition) {
        let position = PlayerPosition(exact: exactPosition)
        coloredRectangleColor = position.color
        text = exactPosition.rawValue
    }
}

class PositionSectionHeaderView: CustomTableViewHeaderFooterView, Reusable {

    // MARK: - Properties
    let coloredPositionLabel = ColoredPositionLabel(style: .sectionTitle)

    static let reuseIdentifier: String = "PositionSectionHeaderView"

    // MARK: - Inherited
    final override func setupSubviews() {
        add(subview: coloredPositionLabel)
        coloredPositionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        coloredPositionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    // MARK: - Public
    public var text: String = "" {
        didSet {
            coloredPositionLabel.text = text
        }
    }

    public var positionColor: UIColor = .primary {
        didSet {
            coloredPositionLabel.coloredRectangleColor = positionColor
        }
    }
}

class SectionHeaderView: CustomTableViewHeaderFooterView, Reusable {

    // MARK: - Properties
    let sectionTitleLabel = UILabel(style: .sectionTitle)

    static let reuseIdentifier: String = "SectionHeaderView"

    // MARK: - Inherited
    final override func setupSubviews() {
        add(subview: sectionTitleLabel)
        sectionTitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        sectionTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    // MARK: - Public
    public var text: String = "" {
        didSet {
            sectionTitleLabel.text = text
        }
    }
}
