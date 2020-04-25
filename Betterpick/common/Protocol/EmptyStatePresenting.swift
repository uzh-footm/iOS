//
//  EmptyStatePresenting.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

protocol EmptyStatePresenting: class {
    associatedtype EmptyStateView: UIView
    var emptyStateView: EmptyStateView? { get set }
    var emptyStateSuperview: UIView { get }
    func addEmptyState() -> EmptyStateView?
    func removeEmptyState()
}

extension EmptyStatePresenting where Self: UIViewController {
    @discardableResult
    func addEmptyState() -> EmptyStateView? {
        guard emptyStateView == nil else { return nil }
        let empty = EmptyStateView()
        emptyStateView = empty
        view.insertSubview(empty, aboveSubview: emptyStateSuperview)
        empty.embed(in: emptyStateSuperview)
        return emptyStateView
    }

    func removeEmptyState() {
        emptyStateView?.removeFromSuperview()
        emptyStateView = nil
    }
}
