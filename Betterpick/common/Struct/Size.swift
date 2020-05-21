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
    static let extendedMargin: CGFloat = 24
    static let doubleStandardMargin: CGFloat = 2 * standardMargin

    static let toolbarHeight: CGFloat = 35

    struct Label {
        static let ovrValueWidth: CGFloat = 30
        static let ovrValueHeight: CGFloat = 18
    }

    struct Image {
        /// Icon size of the back button
        static let smallerIconSize: CGFloat = 20
        /// Icon size of action buttons
        static let iconSize: CGFloat = 24
        /// TabBarIcon sizes
        static let tabBarIcon: CGFloat = 30
        /// Size of the teamLogo in a `UITableViewCell`
        static let teamLogo: CGFloat = 40
        /// Size of the team logo in Team detail
        static let bigTeamLogo: CGFloat = 80
        /// Size of the player photo in a `UITableViewCell`
        static let playerPhoto: CGFloat = 40
        /// Size of the player photo in Player detail
        static let bigPlayerPhoto: CGFloat = 112
    }

    struct Cell {
        static let height: CGFloat = 40
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
