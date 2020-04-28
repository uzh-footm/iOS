//
//  DiscoverTeamViewController+TappableResponderLabelDelegate.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension DiscoverTeamViewController: TappableResponderLabelDelegate {
    var responderInputView: UIView {
        return competitionPickerView
    }

    var responderAccessoryView: UIView? {
        return competitionPickerView.toolbar
    }
}
