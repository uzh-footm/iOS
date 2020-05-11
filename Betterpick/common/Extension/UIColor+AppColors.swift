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

    // MARK: - Initializers
    // swiftlint:disable identifier_name
    private convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        let divisor: CGFloat = 255
        self.init(red: r/divisor, green: g/divisor, blue: b/divisor, alpha: a)
    }
    // swiftlint:enable identifier_name

    private convenience init(same: CGFloat) {
        self.init(r: same, g: same, b: same)
    }

    /// Return light or dark color based on iOS version and userInterfaceStyle
    private static func from(light: UIColor, dark: UIColor) -> UIColor {
        // if iOS < 13.0 then return a light color
        guard #available(iOS 13, *) else { return light }

        // else return the color based on the interface style
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }

    // MARK: - Colors
    public static let primary: UIColor = #colorLiteral(red: 0.3843137255, green: 0.7882352941, blue: 0.3529411765, alpha: 1)
    public static let tabBarButtonDeselected: UIColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    public static let outlineGray: UIColor = UIColor(r: 140, g: 140, b: 141)

    // MARK: Backgrounds
    // Sub iOS 13.0 backwards compatible colors
    public static var compatibleSystemBackground: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
        return .systemBackground
    }()

    public static var backgroundAccent: UIColor = {
        let diff: CGFloat = 6
        let max: CGFloat = 255
        return from(light: UIColor(same: max-diff), dark: UIColor(same: 2*diff))
    }()

    public static var compatibleSystemGroupedBackground: UIColor = {
        guard #available(iOS 13, *) else { return .groupTableViewBackground }
        return .systemGroupedBackground
    }()

    public static var compatibleSecondarySystemGroupedBackground: UIColor = {
           guard #available(iOS 13, *) else { return .white }
           return .secondarySystemGroupedBackground
       }()

    public static var compatibleTertiarySystemFill: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1) }
        return .tertiarySystemFill
    }()

    // MARK: Separators
    public static var customSeparator: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.29) }
        return .separator
    }()

    public static var customOpaqueSeparator: UIColor = {
        guard #available(iOS 13, *) else { return #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1) }
        return .opaqueSeparator
    }()

    // MARK: Labels
    public static var customLabel: UIColor = {
        guard #available(iOS 13, *) else { return .black }
        return .label
    }()

    public static var customSecondaryLabel: UIColor = {
        guard #available(iOS 13, *) else { return outlineGray }
        return .secondaryLabel
    }()

    // MARK: Positions
    public static let positionGoalkeeper: UIColor = #colorLiteral(red: 1, green: 0.6443301376, blue: 0, alpha: 1)
    public static let positionDefence: UIColor = #colorLiteral(red: 0.9259597081, green: 0.9016723093, blue: 0.06182791736, alpha: 1)
    public static let positionMiddle: UIColor = #colorLiteral(red: 0.2024282716, green: 0.7287436548, blue: 0.0695014862, alpha: 1)
    public static let positionAttack: UIColor = #colorLiteral(red: 0.3410514721, green: 0.6519633679, blue: 1, alpha: 1)

    // MARK: OVR
    // 0 - worst, 5 - best
    public static let ovr0: UIColor = #colorLiteral(red: 0.9215686275, green: 0.3019607843, blue: 0.3058823529, alpha: 1)
    public static let ovr1: UIColor = #colorLiteral(red: 0.9411764706, green: 0.6549019608, blue: 0.2745098039, alpha: 1)
    public static let ovr2: UIColor = #colorLiteral(red: 0.9099896113, green: 0.868210565, blue: 0.1895468792, alpha: 1)
    public static let ovr3: UIColor = #colorLiteral(red: 0.5764705882, green: 0.6823529412, blue: 0.3411764706, alpha: 1)
    public static let ovr4: UIColor = #colorLiteral(red: 0.4, green: 0.7921568627, blue: 0.2941176471, alpha: 1)
}
