//
//  PlayerFilterViewController+TableView.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension PlayerFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch viewModel.section(at: section) {
        case .sort:
            viewModel.selectSortOrder(at: indexPath.row)
            tableView.reloadSections(IndexSet([section]), with: .automatic)
        case .playerInfo:
            if let cell = tableView.cellForRow(at: indexPath) as? PickerResponderTableViewCell {
                lastSelectedIndexPath = indexPath
                cell.becomeFirstResponder()
            }
        case .reset:
            viewModel.resetFilterData()
            nationalityPickerView.resetSelection()
            positionPickerView.resetSelection()
            UIView.transition(with: tableView, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.tableView.reloadData()
            }, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension PlayerFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch viewModel.section(at: indexPath.section) {
        case .sort:
            let cell = UITableViewCell()
            let cellData = viewModel.getSortSectionData(at: row)
            cell.tintColor = .primary
            cell.textLabel?.text = cellData.text
            cell.accessoryType = cellData.selected ? .checkmark : .none
            return cell
        case .playerInfo:
            let playerInfoRowType = viewModel.getPlayerInfoSectionRow(at: row)
            switch playerInfoRowType {
            case .nationality:
                let cell = PickerResponderTableViewCell(style: .value1, reuseIdentifier: nil)
                cell.textLabel?.text = "Nationality"
                cell.detailTextLabel?.text = viewModel.detailTextForNationality()
                nationalityPickerHandler.cell = cell
                nationalityPickerHandler.reselectPreviouslySelectedRows()
                nationalityPickerView.toolbarDelegate = self
                return cell
            case .position:
                let cell = PickerResponderTableViewCell(style: .value1, reuseIdentifier: nil)
                cell.textLabel?.text = "Position"
                cell.detailTextLabel?.text = viewModel.detailTextForPosition()
                positionPickerHandler.cell = cell
                positionPickerHandler.reselectPreviouslySelectedRows()
                positionPickerView.toolbarDelegate = self
                return cell
            case .ovrRange:
                let cell = RangeSliderTableViewCell()
                // FIXME: Move to some OVR Range model
                cell.rangeSlider.lowerValue = Double(viewModel.playerFilterData.ovrGreaterThanOrEqual - PlayerFilterData.minimumOvr) / Double(abs(PlayerFilterData.maximumOvr - PlayerFilterData.minimumOvr))
                cell.rangeSlider.upperValue = Double(viewModel.playerFilterData.ovrLessThanOrEqual - PlayerFilterData.minimumOvr) / Double(abs(PlayerFilterData.maximumOvr - PlayerFilterData.minimumOvr))
                // ENDFIXME
                // Add ValueChanged action
                cell.rangeSlider.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
                cell.valueInfoLabel.text = "OVR"
                cell.valueLabel.text = ""
                rangeCell = cell
                updateRangeCellAppearance()
                return cell
            }
        case .reset:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Reset filters"
            cell.textLabel?.set(style: .cellCenteredAction)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.section(at: section).sectionHeaderText
    }
}
