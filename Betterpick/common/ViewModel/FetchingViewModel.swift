//
//  FetchingViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// Represents ViewModels that fetch some resource (`FetchingResponseBody`) and then transform it into a displayable `Model`.
class FetchingViewModel<FetchingResponseBody: Decodable, Model> {

    enum ViewState {
        case fetching
        case displaying(Model)
        case error(Error)
    }

    // MARK: - Properties
    let apiManager: BetterpickAPIManager

    // MARK: ViewState
    var state: ViewState = .fetching {
        didSet { handleStateChange(old: oldValue, new: state) }
    }
    private var isInitialFetch = true

    // MARK: Actions
    var onStateUpdate: (() -> Void)?

    // MARK: - Initialization
    init(apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.apiManager = apiManager
    }

    // MARK: - Private
    private func handleStateChange(old: ViewState, new: ViewState) {
        switch (old, new) {
        case (.fetching, .fetching):
            // Initial fetch
            onInitialFetching()
        case (.fetching, .displaying(let model)):
            if isInitialFetch {
                onFinishedInitialFetching(model: model)
                isInitialFetch = false
            } else {
                onFinishedFetching(model: model)
            }
        case (.displaying, .fetching):
            onRefetching()
        default:
            break
        }
        // Notify the view
        onStateUpdate?()
    }

    // MARK: - Open
    /// Override this func in the subclasses with the appropriate apiManager call.
    /// - important: Don't call this function directly.
    open func startFetching(completion: @escaping BetterpickAPIManager.Callback<FetchingResponseBody>) {

    }

    /// Override this func to return the model that will be created from the response body and displayed by the view.
    open func responseBodyToModel(_ responseBody: FetchingResponseBody) -> Model? {
        return nil
    }

    // MARK: On State Change Notifications
    /// Called when the viewModel starts the initial fetching.
    open func onInitialFetching() {

    }

    /// Called when the initial fetching is finished
    open func onFinishedInitialFetching(model: Model) {

    }

    /// Called when the fetching is finished
    open func onFinishedFetching(model: Model) {

    }

    /// Called when the viewModel refetches the views.
    open func onRefetching() {

    }

    // MARK: - Public
    /// Call this function after the view loads or whenever you want to start fetching.
    public final func start() {
        state = .fetching
        startFetching { [weak self] result in
            switch result {
            case .error(let error):
                self?.state = .error(error)
            case .success(let responseBody):
                guard let model = self?.responseBodyToModel(responseBody) else { return }
                self?.state = .displaying(model)
            }
        }
    }

    public var model: Model? {
        guard case .displaying(let model) = state else { return nil }
        return model
    }
}
