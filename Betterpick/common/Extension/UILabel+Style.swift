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
        // Cells
        case cellTitle
        case cellCenteredAction
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
        // Cells
        case .cellTitle:
            textColor = .customLabel
            font = UIFont.systemFont(ofSize: Size.Font.action, weight: .medium)
        case .cellCenteredAction:
            textColor = .primary
            textAlignment = .center
            font = UIFont.systemFont(ofSize: Size.Font.action)
        }
    }
}
