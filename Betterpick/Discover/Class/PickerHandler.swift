//
//  PickerHandler.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// This base class is responsible for implementing the core delegate work on a UIPickerView that is used as an inputView in a `UITableViewCell`.
class PickerHandler<ViewModel: AnyObject>: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, CustomResponderViewDelegate {

    // MARK: - Properties
    weak var viewModel: ViewModel?
    weak var cell: PickerResponderTableViewCell? {
        didSet {
            guard let cell = cell else { return }
            cell.responderDelegate = self
        }
    }
    weak var pickerView: ToolbarPickerView?

    /// Dictionary with Component as keys and Rows as values
    var selectedRows: [Int: Int] = [:]

    // MARK: - Initialization
    init(viewModel: ViewModel, pickerView: ToolbarPickerView) {
        self.viewModel = viewModel
        self.pickerView = pickerView
        super.init()
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Tag the selected row
        selectedRows[component] = row

        let numComponents = numberOfComponents(in: pickerView)
        // If we have multiple components and the user didn't select a row in the last one
        guard numComponents > 1, component != numComponents - 1 else { return }
        for componentIndex in component + 1..<numComponents {
            // Reload the more specific wheels
            pickerView.reloadComponent(componentIndex)
            // select the first row in each reloaded wheel
            pickerView.selectRow(0, inComponent: componentIndex, animated: true)
        }
    }

    // MARK: - CustomResponderViewDelegate
    var responderInputView: UIView {
        return pickerView ?? UIView()
    }

    // MARK: - Open
    /// Selects the rows that were selected previously. Use this function if you want to reload the state of the picker view (i.e. after dismissing and presenting the VC that displayed this pickerView)
    func reselectPreviouslySelectedRows() {
        let orderedComponents = selectedRows.keys.sorted()
        for componentIndex in orderedComponents {
            guard let rowIndex = selectedRows[componentIndex] else { continue }
            pickerView?.fakeUserInteractiveSelect(at: rowIndex, inComponent: componentIndex, animated: false)
        }
    }
}
