//
//  PlayerFilterViewController.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerFilterViewController: VMViewController<PlayerFilterViewModel> {

    // MARK: - Properties
    var onFinishedFiltering: ((PlayerFilterData) -> Void)?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
    }

}
