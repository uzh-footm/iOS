//
//  CustomTextField.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    // MARK: - Properties
    private static let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    private static let fontSize: CGFloat = 19

    // MARK: - Inherited
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Sizing
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Size.componentHeight)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: CustomTextField.padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: CustomTextField.padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: CustomTextField.padding)
    }

    // MARK: - Private
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        clearButtonMode = .whileEditing
        autocapitalizationType = .words
        font = UIFont.systemFont(ofSize: CustomTextField.fontSize)
        tintColor = .primary
    }

    // MARK: - Public
    /// Set placeholder text inside the `CustomTextField`
    public func setPlaceholder(text: String) {
        let placeholderFontSize = CustomTextField.fontSize - 1
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: placeholderFontSize)]
        attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}
