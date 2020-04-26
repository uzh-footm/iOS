//
//  TeamListSeparatorAnimator.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// Handles the animation of a Separator `UIView` depending on the `scrollView.contentOffset.y`
class TeamsListSeparatorAnimator {

    // MARK: - Properties
    weak var separator: UIView?

    // MARK: - Private
    /// We don't need to trigger the computation every time the delegate invokes the method.
    private func shouldConsiderScroll(contentOffset: CGPoint) -> Bool {
        return Int(contentOffset.y) % 3 == 0
    }

    // MARK: - Public
    public func handleScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldConsiderScroll(contentOffset: scrollView.contentOffset) else { return }
        let shouldShowSeparator = scrollView.contentOffset.y > 0
        let shouldHideSeparator = !shouldShowSeparator

        if shouldShowSeparator, separator?.isHidden ?? false {
            UIView.animate(withDuration: 0.4) {
                self.separator?.isHidden = false
            }
        } else if shouldHideSeparator, !(separator?.isHidden ?? true) {
            UIView.animate(withDuration: 0.4) {
                self.separator?.isHidden = true
            }
        }
        guard scrollView.contentOffset.y > 0, let sep = separator, sep.isHidden else { return }
    }
}
