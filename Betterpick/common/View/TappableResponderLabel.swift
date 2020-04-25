//
//  TappableResponderLabel.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TappableResponderLabel: TappableLabel {

    // MARK: - Properties
    weak var delegate: TappableResponderLabelDelegate?

    // MARK: - Overrides
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var inputView: UIView? {
        return delegate?.responderInputView
    }

    override var inputAccessoryView: UIView? {
        return delegate?.responderAccessoryView
    }
}

protocol TappableResponderLabelDelegate: class {
    var responderInputView: UIView { get }
    var responderAccessoryView: UIView? { get }
}

extension TappableResponderLabelDelegate {
    var responderAccessoryView: UIView? { return nil }
}

protocol ToolbarPickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

class ToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .customLabel
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        doneButton.tintColor = .primary
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc private func doneTapped() {
        self.toolbarDelegate?.didTapDone()
    }

    @objc private func cancelTapped() {
        self.toolbarDelegate?.didTapCancel()
    }
}
