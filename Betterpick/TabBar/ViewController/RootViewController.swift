//
//  RootViewController.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class RootViewController: VMViewController<RootViewModel>, FetchingStatePresenting {

    // MARK: - Properties
    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateSuperview: UIView { return view }
    var fetchingStateView: FetchingStateView?

    // MARK: Actions
    var onDataLoaded: ((LeagueAndNationalityData) -> Void)?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .compatibleSystemBackground

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance
        viewModel.onDataLoaded = onDataLoaded
        viewModel.start()
    }

    // MARK: - Private
    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .error(let error):
            addFetchingStateView()
            showErrorState(error: error)
        case .fetching:
            addFetchingStateView()
        case .displaying:
            removeFetchingStateView()
        }
    }
}
