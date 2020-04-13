//
//  TabBarStackView.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TabBarStackView: UIStackView {

    // MARK: - Properties
    var buttons: [UIButton] = []
    // Static
    private let buttonSelectedColor = UIColor.primary
    private let buttonDeselectedColor = UIColor.tabBarButtonDeselected

    // MARK: - Initialization
    init(tabs: Tabs) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        setupSubviews(tabs: tabs)
    }

    required init(coder: NSCoder) { super.init(coder: coder) }

    // MARK: - Private
    private func setupSubviews(tabs: Tabs) {
        // swiftlint:disable identifier_name
        for (i, tab) in tabs.enumerated() {
        // swiftlint:enable identifier_name
            // Create a button for each Tab
            let button = UIButton()
            button.tag = i
            button.tintColor = buttonDeselectedColor
            // Set button icon depending on the state
            let deselectedImg = tab.image.withRenderingMode(.alwaysTemplate)
            let selectedImg = tab.highlightedImage.withRenderingMode(.alwaysTemplate)
            button.setImage(deselectedImg, for: .normal)
            button.setImage(deselectedImg, for: .highlighted)
            button.setImage(selectedImg, for: .selected)
            // If the button is both, selected && highlighted, show selected image.
            button.setImage(selectedImg, for: [.selected, .highlighted])
            button.imageView?.contentMode = .scaleAspectFit
            // Add it to our stack of views
            addArrangedSubview(button)
            // Add the button to our button array
            buttons.append(button)
        }
    }

    // MARK: - Public
    public func updateAppearance(selectedIndex: Int) {
        // Deselect previously selected tab
        for button in buttons where button.isSelected {
            button.tintColor = buttonDeselectedColor
            button.isSelected = false
        }
        // Select new tab
        if let selected = buttons.first(where: { $0.tag == selectedIndex }) {
            selected.tintColor = buttonSelectedColor
            selected.isSelected = true
        }
    }

}
