//
//  ToolbarPickerViewDelegate.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

protocol ToolbarPickerViewDelegate: class {
    func didTapDone(_ pickerView: ToolbarPickerView)
    func didTapCancel(_ pickerView: ToolbarPickerView)
}
