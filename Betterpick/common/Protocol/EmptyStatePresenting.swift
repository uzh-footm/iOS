//
//  FetchingStatePresenting.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol FetchingStatePresenting: class {
    associatedtype FetchingStateView: UIView
    var fetchingStateView: FetchingStateView? { get set }
    var fetchingStateSuperview: UIView { get }
    func addFetchingStateView() -> FetchingStateView?
    func removeFetchingStateView()
}

extension FetchingStatePresenting where Self: UIViewController {
    @discardableResult
    func addFetchingStateView() -> FetchingStateView? {
        guard fetchingStateView == nil else { return nil }
        let empty = FetchingStateView()
        fetchingStateView = empty
        view.insertSubview(empty, aboveSubview: fetchingStateSuperview)
        empty.embed(in: fetchingStateSuperview)
        return fetchingStateView
    }

    func removeFetchingStateView() {
        fetchingStateView?.removeFromSuperview()
        fetchingStateView = nil
    }
}
