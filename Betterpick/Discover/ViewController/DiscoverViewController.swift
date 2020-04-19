//
//  DiscoverViewController.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        // NavBar
        //hideNavBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Discover"
    }

    // MARK: - Private
    private func hideNavBar() {
//        navigationBar.shadowImage = UIImage()
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.isTranslucent = true
//        navigationBar.backgroundColor = .clear
    }

}
