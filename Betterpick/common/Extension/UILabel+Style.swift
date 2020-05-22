//
//  UILabel+Style.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension UILabel {

    enum Style {
        case primary
        case secondary
        case largeTitle
        case title
        case sectionTitle
        // Cells
        case cellTitle
        case cellValue1
        case cellCenteredAction
        case cellPrimary
        case cellSecondary
        // Player
        case playerFirstName
        case playerValueText
        case playerStaticText
        // Special
        /// Used with the OverallValueLabel
        case ovrLabel
        case creditsLabel
    }

    convenience init(style: Style) {
        self.init(frame: .zero)
        set(style: style)
    }

    // swiftlint:disable function_body_length
    func set(style: Style) {
        numberOfLines = 0
        switch style {
        case .primary:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 14)
        case .secondary:
            textColor = .customSecondaryLabel
            font = UIFont.systemFont(ofSize: 14)
            numberOfLines = 1
            adjustsFontSizeToFitWidth = true
            minimumScaleFactor = 0.5
        case .largeTitle:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 34, weight: .bold)
        case .title:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        case .sectionTitle:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 14, weight: .medium)
        // Cells
        case .cellTitle:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: Size.Font.action)
        case .cellValue1:
            textColor = .customSecondaryLabel
            font = UIFont.systemFont(ofSize: Size.Font.action)
        case .cellCenteredAction:
            textColor = .primary
            textAlignment = .center
            font = UIFont.systemFont(ofSize: Size.Font.action)
        case .cellPrimary:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 13)
            numberOfLines = 1
        case .cellSecondary:
            textColor = .customSecondaryLabel
            font = UIFont.systemFont(ofSize: 13)
            numberOfLines = 1
        // Player
        case .playerFirstName:
            textColor = .customSecondaryLabel
            font = UIFont.systemFont(ofSize: 18, weight: .medium)
            numberOfLines = 1
        case .playerStaticText:
            textColor = UIColor.customLabel.withAlphaComponent(0.7)
            font = UIFont.systemFont(ofSize: 14)
        case .playerValueText:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            numberOfLines = 1
        // Special
        case .ovrLabel:
            textColor = .white
            textAlignment = .center
            font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        case .creditsLabel:
            textColor = .customSecondaryLabel
            font = UIFont.systemFont(ofSize: 11)
            numberOfLines = 1
            adjustsFontSizeToFitWidth = true
            minimumScaleFactor = 0.5
        }
    }
    // swiftlint:enable function_body_length
}
