//
//  PlayerDetailViewController.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerDetailViewController: VMViewController<PlayerDetailViewModel>, FetchingStatePresenting {

    // MARK: - Properties
    // MARK: UI

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateSuperview: UIView { return view }
    var fetchingStateView: FetchingView?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background

        viewModel.onStateUpdate = updateViewStateAppearance

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .fetching:
            addFetchingStateView()
        case .displaying(let player):
            removeFetchingStateView()
        case .error:
            addFetchingStateView()
        }
    }
}
