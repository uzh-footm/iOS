//
//  ActionButton.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    // MARK: - Properties
    private static let increasedTapAreaInset: CGFloat = 10

    // MARK: - Inherited
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // Increases the tappable area of the ActionButton
        let inset = -ActionButton.increasedTapAreaInset
        let newBounds = bounds.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
        return newBounds.contains(point)
    }

    // MARK: - Public
    /// Returns an `ActionButton` with `UIButton.Type = system`.
    public static func createActionButton(image: UIImage, target: Any?, action: Selector?) -> ActionButton {
        let button = ActionButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .primary
        button.imageView?.contentMode = .scaleAspectFit
        if let selector = action {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        return button
    }

    public static func createActionBarButtonItem(image: UIImage, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barImage = image.withRenderingMode(.alwaysTemplate)
        let button = UIBarButtonItem(image: barImage, style: .plain, target: target, action: action)
        button.tintColor = .primary
        return button
    }
}
