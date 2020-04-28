//
//  DiscoverTeamViewController+PickerView.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// MARK: - UIPickerViewDelegate
extension DiscoverTeamViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.league(at: row)?.name
    }
}

// MARK: - UIPickerViewDataSource
extension DiscoverTeamViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfLeagues()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - ToolbarPickerViewDelegate
extension DiscoverTeamViewController: ToolbarPickerViewDelegate {
    func didTapDone() {
        let row = competitionPickerView.selectedRow(inComponent: 0)
        viewModel.fetchLeague(at: row)
        competitionInfoLabel.resignFirstResponder()
    }

    func didTapCancel() {
        competitionInfoLabel.resignFirstResponder()
    }
}
