//
//  DiscoverViewController+ChildViewControllerContainerProviding.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

extension DiscoverViewController: ChildViewControllerContainerProviding {
    var childViewControllerContainerView: UIView {
        return sectionContainerView
    }
}
