//
//  CustomResponderViewDelegate.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol CustomResponderViewDelegate: class {
    var responderInputView: UIView { get }
    var responderAccessoryView: UIView? { get }
}

extension CustomResponderViewDelegate {
    var responderAccessoryView: UIView? {
        if let toolbarPickerView = responderInputView as? ToolbarPickerView {
            return toolbarPickerView.toolbar
        }
        return nil
    }
}
