//
//  ChildViewControllerContainerProviding.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol ChildViewControllerContainerProviding {
    var childViewControllerContainerView: UIView { get }
}

extension ChildViewControllerContainerProviding where Self: UIViewController {
    // Embed a  view controller inside the container view
    func embed(viewController viewC: UIViewController) {
        // Add the child view controller
        add(childViewController: viewC, superview: childViewControllerContainerView)
        // Embed it inside our container view
        viewC.view.translatesAutoresizingMaskIntoConstraints = false
        viewC.view.leadingAnchor.constraint(equalTo: childViewControllerContainerView.leadingAnchor).isActive = true
        viewC.view.trailingAnchor.constraint(equalTo: childViewControllerContainerView.trailingAnchor).isActive = true
        viewC.view.topAnchor.constraint(equalTo: childViewControllerContainerView.topAnchor).isActive = true
        viewC.view.bottomAnchor.constraint(equalTo: childViewControllerContainerView.bottomAnchor).isActive = true
    }
}
