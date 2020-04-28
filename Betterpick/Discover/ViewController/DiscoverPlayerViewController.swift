//
//  DiscoverPlayerViewController.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverPlayerViewController: UIViewController {

    // MARK: - Properties
    weak var playerSelectingCoordinator: PlayerSelecting?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primary
    }

}
