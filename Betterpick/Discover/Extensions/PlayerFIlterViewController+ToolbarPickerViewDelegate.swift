//
//  PlayerFIlterViewController+ToolbarPickerViewDelegate.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension PlayerFilterViewController: ToolbarPickerViewDelegate {
    func didTapCancel(_ pickerView: ToolbarPickerView) {
        for handler in [nationalityPickerHandler, positionPickerHandler] where handler.pickerView === pickerView {
            handler.cell?.resignFirstResponder()
            break
        }
    }

    func didTapDone(_ pickerView: ToolbarPickerView) {
        // Nationality
        if pickerView === nationalityPickerHandler.pickerView {
            let nationalityRow = nationalityPickerView.selectedRow(inComponent: 0)
            viewModel.setNationality(from: nationalityRow)
            nationalityPickerHandler.cell?.resignFirstResponder()
        }
        // Position
        if pickerView === positionPickerHandler.pickerView {
            let positionRow = positionPickerView.selectedRow(inComponent: 0)
            let exactPositionRow = positionPickerView.selectedRow(inComponent: 1)
            viewModel.setPosition(from: positionRow, exactPositionRow: exactPositionRow)
            positionPickerHandler.cell?.resignFirstResponder()
        }
        // Reload the rows that should change their value
        if let lastIndexPath = lastSelectedIndexPath {
            tableView.reloadRows(at: [lastIndexPath], with: .none)
        }
    }
}
