//
//  DiscoverCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverCoordinator: ChildCoordinator {

    // MARK: - Properties
    let discoverViewController: DiscoverViewController
    var searchCoordinator: SearchCoordinator?

    // MARK: ChildCoordinator
    var viewController: UIViewController { return discoverViewController }

    // MARK: - Initialization
    init(discoverViewController: DiscoverViewController) {
        self.discoverViewController = discoverViewController
    }

    // MARK: - Lifecycle
    func start() {
        discoverViewController.onSearchAction = { [unowned self] in
            self.startSearchFlow()
        }
    }

    // MARK: - Action Handlers
    func startSearchFlow() {
        // Guard that we are not doing another search right now
        guard searchCoordinator == nil else { return }
        // Create a new SearchViewController and its Coordinator
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.onFinishedSearching = { [unowned self] in
            self.finishSearchFlow()
        }
        searchCoordinator = SearchCoordinator(searchViewController: searchVC)
        discoverViewController.present(searchVC, animated: false, completion: nil)
    }

    func finishSearchFlow() {
        // Guard that some search coordinator is active
        guard let activeSearchCoordinator = searchCoordinator else { return }
        activeSearchCoordinator.searchViewController.dismiss(animated: false, completion: nil)
        searchCoordinator = nil
    }
}
