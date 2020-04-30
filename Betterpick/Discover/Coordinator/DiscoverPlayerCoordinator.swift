//
//  DiscoverPlayerCoordinator.swift
//  Betterpick
//
//  Created by David Bielik on 20/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverPlayerCoordinator: NSObject, SectionedCoordinator {

    // MARK: - Properties
    var viewController: UIViewController {
        return discoverPlayerViewController
    }

    let discoverPlayerViewController: DiscoverPlayerViewController

    // MARK: Child Coordinators
    var playerFilterCoordinator: PlayerFilterCoordinator?

    // MARK: - Initialization
    init(discoverPlayerViewController: DiscoverPlayerViewController) {
        self.discoverPlayerViewController = discoverPlayerViewController
    }

    // MARK: - Private
    private func commonFinishPlayerFilterFlow(playerFilterData: PlayerFilterData) {
        discoverPlayerViewController.viewModel.set(playerFilterData: playerFilterData)
        playerFilterCoordinator = nil
    }

    // MARK: - Coordinator
    func start() {
        discoverPlayerViewController.onFilterAction = startPlayerFilterFlow
    }

    func startPlayerFilterFlow() {
        // Guard that we are not in progress of filtering right now
        guard playerFilterCoordinator == nil else { return }
        // Create a new PlayerFilterViewController and its Coordinator
        let currentFilterData = discoverPlayerViewController.viewModel.playerFilterData
        let playerFilterVM = PlayerFilterViewModel(playerFilterData: currentFilterData)
        let playerFilterVC = PlayerFilterViewController(viewModel: playerFilterVM)
        playerFilterVC.modalPresentationStyle = .pageSheet
        playerFilterVC.onFinishedFiltering = finishPlayerFilterFlow
        playerFilterVC.presentationController?.delegate = self
        playerFilterCoordinator = PlayerFilterCoordinator(playerFilterViewController: playerFilterVC)
        viewController.present(playerFilterVC, animated: true, completion: nil)
    }

    func finishPlayerFilterFlow(playerFilterData: PlayerFilterData) {
        // Guard that some filter coordinator is already being presented
        guard let activePlayerFilterCoordinator = playerFilterCoordinator else { return }
        activePlayerFilterCoordinator.viewController.dismiss(animated: true, completion: nil)
        commonFinishPlayerFilterFlow(playerFilterData: playerFilterData)
    }
}

// MARK: - UIAdaptivePresntationControllerDelegate
extension DiscoverPlayerCoordinator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // If the PlayerFilterViewController was dismissed interactively (e.g. the user panning the VC down)
        if let playerFilterVC = presentationController.presentedViewController as? PlayerFilterViewController, playerFilterCoordinator != nil {
            let playerFilterData = playerFilterVC.viewModel.playerFilterData
            commonFinishPlayerFilterFlow(playerFilterData: playerFilterData)
        }
    }
}
