//
//  PlayerPreviewDataStackView.swift
//  Betterpick
//
//  Created by David Bielik on 08/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerPreviewDataStackView: UIStackView {

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private
    private func setup() {
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 3
        translatesAutoresizingMaskIntoConstraints = false
    }

    @discardableResult
    private func addLabel(with text: String, priority: UILayoutPriority) -> UILabel {
        let label = UILabel(style: .cellSecondary)
        label.text = text
        addArrangedSubview(label)
        label.setContentHuggingPriority(priority, for: .horizontal)
        return label
    }

    private func updateLabels() {
        guard !textData.isEmpty else { return }

        // remove subviews if needed
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        var textDataCopy = textData
        let lastText = textDataCopy.removeLast()
        for text in textDataCopy {
            addLabel(with: text, priority: .init(251))

            let bulletpointLabel = addLabel(with: "\u{00B7}", priority: .init(251))
            bulletpointLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        }

        let lastLabel = addLabel(with: lastText, priority: .init(250))

        // Set content compression resistance for the first and last label
        // prevents the first and last labels from getting shrunk.
        // Shrinks the labels in the middle instead.
        lastLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        let labels = arrangedSubviews.filter({ $0 is UILabel })
        guard labels.count > 1, let first = labels.first else { return }
        first.setContentCompressionResistancePriority(.init(751), for: .horizontal)
    }

    // MARK: - Public
    public var textData: [String] = [] {
        didSet {
            updateLabels()
        }
    }
}
