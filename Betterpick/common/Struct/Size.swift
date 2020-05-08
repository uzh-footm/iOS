//
//  Size.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

struct Size {
    static let textFieldSpacing: CGFloat = 14
    static let componentSpacing: CGFloat = textFieldSpacing * 2.5
    static let componentHeight: CGFloat = 44
    static let headerHeight: CGFloat = 50
    static let componentWidthRelativeToScreenWidth: CGFloat = 0.8

    static let standardMargin: CGFloat = 16
    static let extendedMargin: CGFloat = 18
    static let doubleStandardMargin: CGFloat = 2 * standardMargin

    static let toolbarHeight: CGFloat = 35

    struct Label {
        static let ovrValueWidth: CGFloat = 30
        static let ovrValueHeight: CGFloat = 18
    }

    struct Image {
        static let smallerIconSize: CGFloat = 20
        static let iconSize: CGFloat = 24
        static let tabBarIcon: CGFloat = 30
        static let teamLogo: CGFloat = 48
        static let bigTeamLogo: CGFloat = 80
        static let playerPhoto: CGFloat = 40
    }

    struct Cell {
        static let height: CGFloat = 48
        static let tinyVerticalMargin: CGFloat = 2
        static let verticalMargin: CGFloat = 6
        static let extendedSideMargin: CGFloat = 18
    }

    struct TableView {
        static let headerHeight: CGFloat = 24
    }

    struct Navigator {
        static let height: CGFloat = 44
        static let separatorHeight: CGFloat = 1
        static let barButtonBottomMargin: CGFloat = 12
    }

    struct Tab {
        static let height: CGFloat = 50
    }

    struct Font {
        static let `default`: CGFloat = 14
        static let action: CGFloat = 16
    }
}
