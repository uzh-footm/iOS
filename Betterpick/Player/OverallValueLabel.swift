//
//  OverallValueLabel.swift
//  Betterpick
//
//  Created by David Bielik on 08/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class OverallValueLabel: UILabel {

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private
    private func setup() {
        set(style: .ovr)

        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: Size.Label.ovrValueWidth).isActive = true
        heightAnchor.constraint(equalToConstant: Size.Label.ovrValueHeight).isActive = true
    }

    private func updateAppearance() {
        // Text
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.outlineGray,
            .foregroundColor: textColor ?? .white,
            .strokeWidth: -1,
            .font: font ?? UIFont.systemFont(ofSize: Size.Font.default)
        ]
        attributedText = NSAttributedString(string: String(ovr), attributes: attributes)
        // Background Color
        switch ovr {
        case Int.min..<50:
            backgroundColor = .ovr0
        case 50..<65:
            backgroundColor = .ovr1
        case 65..<80:
            backgroundColor = .ovr2
        case 80..<90:
            backgroundColor = .ovr3
        case 90...Int.max:
            backgroundColor = .ovr4
        default:
            break
        }
    }

    // MARK: - Public
    public var ovr: Int = 0 {
        didSet {
            updateAppearance()
        }
    }
}
