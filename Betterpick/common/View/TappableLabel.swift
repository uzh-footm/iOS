//
//  TappableLabel.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TappableLabel: UILabel {

    // MARK: - Properties
    var hypertextRange: NSRange?

    // MARK: Animation
    private struct Animation {
        static let highlightColor = UIColor.systemGray.withAlphaComponent(0.3)
        static let cornerRadius: CGFloat = 4

        static let forwardDuration: TimeInterval = 0.1
        static let backwardDuration: TimeInterval = 0.05
    }
    var hypertextOverlayView: UIView?

    // MARK: Actions
    var onHypertextTapped: (() -> Void)?

    // MARK: - Inherited
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Private
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingMiddle
        // Enable user interaction
        isUserInteractionEnabled = true
        textColor = .systemGray

        // Add gesture recognizer for tapping on the hypertext
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(recognizer:)))
        recognizer.minimumPressDuration = 0
        addGestureRecognizer(recognizer)
    }

    @objc private func didLongPress(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            let locationInView = recognizer.location(in: self)
            guard let boundingRect = boundingRectForHypertextRange(), boundingRect.contains(locationInView) else { return }
            onLabelLongPress(hypertextRect: boundingRect)
        case .failed, .cancelled, .ended:
            onLabelLongPressEnded()
        default: break
        }
    }

    private func onLabelLongPress(hypertextRect: CGRect) {
        guard hypertextOverlayView == nil else { return }
        let hypertextOverlayView = UIView(frame: hypertextRect)
        insertSubview(hypertextOverlayView, at: 0)
        hypertextOverlayView.layer.cornerRadius = Animation.cornerRadius
        self.hypertextOverlayView = hypertextOverlayView
        UIView.animate(withDuration: Animation.forwardDuration, delay: 0, options: [.curveEaseIn], animations: {
            hypertextOverlayView.backgroundColor = Animation.highlightColor
        }, completion: nil)
    }

    private func onLabelLongPressEnded() {
        guard let highlightedHypertextView = hypertextOverlayView else { return }
        UIView.animate(withDuration: Animation.backwardDuration, delay: 0, options: [.curveEaseOut], animations: {
            highlightedHypertextView.backgroundColor = .clear
        }, completion: { [weak self] _ in
            self?.hypertextOverlayView = nil
        })
        onHypertextTapped?()
    }

    private func setLinkedAttributedText(text: String, link: String, color: UIColor) {
        let defaultFont = font ?? UIFont.systemFont(ofSize: Size.Font.default)
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: defaultFont,
            NSAttributedString.Key.foregroundColor: UIColor.customSecondaryLabel
        ])
        let rangeOfLinkedText = attributedString.mutableString.range(of: link)

        guard rangeOfLinkedText.location != NSNotFound else { return }
        hypertextRange = rangeOfLinkedText
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: rangeOfLinkedText)
        let actionFont = UIFont.systemFont(ofSize: defaultFont.pointSize + 2, weight: .semibold)
        attributedString.addAttribute(NSAttributedString.Key.font, value: actionFont, range: rangeOfLinkedText)
        attributedText = attributedString
    }

    private func boundingRectForHypertextRange() -> CGRect? {
        guard let attributedText = attributedText, let range = hypertextRange else { return nil }

        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()

        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0

        layoutManager.addTextContainer(textContainer)

        var glyphRange = NSRange()

        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        return boundingRect.insetBy(dx: -2, dy: -2)
    }

    // MARK: - Public
    /// Creates an attributed string that has `link` highlighted. Tapping on this part of the text will trigger the `onHypertextTapped` action.
    public func set(hypertext: String, in text: String) {
        setLinkedAttributedText(text: text, link: hypertext, color: .primary)
    }
}
