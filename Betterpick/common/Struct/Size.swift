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
    static let componentWidthRelativeToScreenWidth: CGFloat = 0.8

    static let smallerIconSize: CGFloat = 20
    static let iconSize: CGFloat = 24
    static let standardMargin: CGFloat = 16
    static let extendedMargin: CGFloat = 18
    static let doubleStandardMargin: CGFloat = 2 * standardMargin

    static let toolbarHeight: CGFloat = 35

    struct Image {
        static let tabBarIcon: CGFloat = 30
        static let indicator: CGFloat = 16
        static let teamLogo: CGFloat = 48
    }

    struct Cell {
        static let height: CGFloat = 48
        static let narrowVerticalMargin: CGFloat = 4
        static let narrowSideMargin: CGFloat = 12
        static let sideMargin: CGFloat = 16
        static let extendedSideMargin: CGFloat = 18
        static let wideSideMargin: CGFloat = 40
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
