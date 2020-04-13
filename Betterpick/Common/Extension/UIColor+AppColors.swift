//
//  UIColor+AppColors.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// MARK: - Custom Application Colors
extension UIColor {

    // MARK: Initializers
    // swiftlint:disable identifier_name
    private convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        let divisor: CGFloat = 255
        self.init(red: r/divisor, green: g/divisor, blue: b/divisor, alpha: a)
    }
    // swiftlint:enable identifier_name

    /// Return light or dark color based on iOS version and userInterfaceStyle
    private func from(light: UIColor, dark: UIColor) -> UIColor {
        // if iOS < 13.0 then return a light color
        guard #available(iOS 13, *) else { return light }

        // else return the color based on the interface style
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }

    // MARK: Colors
    public static var primary: UIColor = #colorLiteral(red: 0.3843137255, green: 0.7882352941, blue: 0.3529411765, alpha: 1)
    public static var tabBarButtonDeselected = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)

    // Sub iOS 13.0 backwards compatible colors
    public static var background: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
        return .systemBackground
    }()
    public static var customSeparator: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.29) }
        return .separator
    }()
    public static var customOpaqueSeparator: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1) }
        return .opaqueSeparator
    }()
}
