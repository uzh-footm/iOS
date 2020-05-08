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
        case cellCenteredAction
        case cellPrimary
        case cellSecondary
        // Special
        case ovr
    }

    convenience init(style: Style) {
        self.init(frame: .zero)
        set(style: style)
    }

    func set(style: Style) {
        numberOfLines = 0
        switch style {
        case .primary:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: 14)
        case .secondary:
            textColor = .customSecondaryLabel
            font = UIFont.systemFont(ofSize: 14)
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
            font = UIFont.systemFont(ofSize: Size.Font.action, weight: .medium)
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
        // Special
        case .ovr:
            textColor = .white
            textAlignment = .center
            font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
    }
}
