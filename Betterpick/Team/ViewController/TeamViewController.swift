//
//  TeamViewController.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, NavigationBarDisplaying {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.backgroundColor = .primary

        title = "Team"
    }
}
