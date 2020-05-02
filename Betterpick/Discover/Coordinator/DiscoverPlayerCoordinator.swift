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
    private func commonFinishPlayerFilterFlow(playerFilterData: PlayerFilterData?) {
        if let data = playerFilterData {
            discoverPlayerViewController.viewModel.set(playerFilterData: data)
        }
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
        let nationalities = discoverPlayerViewController.viewModel.nationalities
        let playerFilterVM = PlayerFilterViewModel(playerFilterData: currentFilterData, nationalities: nationalities)
        let playerFilterVC = PlayerFilterViewController(viewModel: playerFilterVM)
        playerFilterVC.onFinishedFiltering = finishPlayerFilterFlow
        let playerFilterCoordinator = PlayerFilterCoordinator(playerFilterViewController: playerFilterVC)
        self.playerFilterCoordinator = playerFilterCoordinator
        playerFilterCoordinator.viewController.modalPresentationStyle = .pageSheet
        playerFilterCoordinator.viewController.presentationController?.delegate = self
        playerFilterCoordinator.start()
        viewController.present(playerFilterCoordinator.viewController, animated: true, completion: nil)
    }

    func finishPlayerFilterFlow(playerFilterData: PlayerFilterData?) {
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
        if let activeCoordinator = playerFilterCoordinator, activeCoordinator.viewController === presentationController.presentedViewController {
            let playerFilterData = activeCoordinator.playerFilterViewController.viewModel.playerFilterData
            commonFinishPlayerFilterFlow(playerFilterData: playerFilterData)
        }
    }
}
