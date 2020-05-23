//
//  TappableResponderLabel.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TappablePickerResponderLabel: TappableLabel {

    // MARK: - Properties
    weak var delegate: CustomResponderViewDelegate?

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
