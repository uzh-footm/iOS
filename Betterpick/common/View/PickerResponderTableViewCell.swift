//
//  PickerResponderTableViewCell.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PickerResponderTableViewCell: UITableViewCell {

    // MARK: - Properties
    weak var responderDelegate: CustomResponderViewDelegate?

    // MARK: - Overrides
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var inputView: UIView? {
        return responderDelegate?.responderInputView
    }

    override var inputAccessoryView: UIView? {
        return responderDelegate?.responderAccessoryView
    }
}
