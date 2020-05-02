//
//  PositionPickerHandler.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PositionPickerHandler: PickerHandler<PlayerFilterViewModel> {

    // MARK: - UIPickerViewDataSource
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let selectedPositionRow = selectedRows[0] ?? pickerView.selectedRow(inComponent: 0)
        return viewModel?.numberOfRowsInPositionPicker(component: component, selectedPositionRow: selectedPositionRow) ?? super.pickerView(pickerView, numberOfRowsInComponent: component)
    }

    // MARK: - UIPickerViewDelegate
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = viewModel?.positionComponentData else { return nil }
        if component == 0 {
            return data.positions[row]?.positionText ?? "Any"
        }

        if component == 1 {
            guard let selected = selectedRows[0] else { return nil }
            let position = data.positions[selected]
            return data.exactPositions[position]?[row]?.rawValue ?? "Any"
        }

        return nil
    }
}
