//
//  NavigationCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class NavigationCoordinator: NSObject, Coordinator {

    // MARK: - Properties
    var childCoordinators = [ChildCoordinator]()
    let navigationController: UINavigationController

    var rootChildCoordinator: ChildCoordinator

    // MARK: - Initialization
    init(navigationController: UINavigationController = UINavigationController(), rootChildCoordinator: ChildCoordinator) {
        self.navigationController = navigationController
        self.rootChildCoordinator = rootChildCoordinator
    }

    // MARK: - Lifecycle
    open func start() {
        let rootViewController = rootChildCoordinator.viewController
        navigationController.delegate = self
        navigationController.setViewControllers([rootViewController], animated: false)
        add(childCoordinator: rootChildCoordinator)
    }

    /// Adds a child coordinator to the `childCoordinators` stack and starts it via `start()`
    func add(childCoordinator: ChildCoordinator) {
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }

    /// Removes a child coordinator from the coordinator hierarchy
    func childDidFinish(_ child: Coordinator?, childIndex: Int? = nil) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Get the from view controller
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        // Guard that the navigation view controller hierarchy doesn't contain the fromViewController
        guard !navigationController.viewControllers.contains(fromViewController) else { return }

        for childCoordinator in childCoordinators where childCoordinator.viewController === fromViewController {
            childDidFinish(childCoordinator)
            break
        }
    }
}
