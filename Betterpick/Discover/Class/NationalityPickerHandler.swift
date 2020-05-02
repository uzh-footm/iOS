//
//  NationalityPickerHandler.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// `PickerHandler` for a cell that displays the nationalities.
class NationalityPickerHandler: PickerHandler<PlayerFilterViewModel> {

    // MARK: - UIPickerViewDataSource
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.nationalities.count ?? super.pickerView(pickerView, numberOfRowsInComponent: component)
    }

    // MARK: - UIPickerViewDelegate
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.nationalities[row].name
    }
}
