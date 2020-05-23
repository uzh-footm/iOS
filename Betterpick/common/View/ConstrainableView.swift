//
//  ConstrainableView.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// A `UIView` subclass that expects autolayout constraints.
/// `translatesAutoresizingMaskIntoConstraints` is set to `false` by default.
class ConstrainableView: UIView {

    // MARK: - Inherited
    init() {
        super.init(frame: .zero)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Private
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }

    // MARK: - Open
    /// Override this function if you want to provide custom view logic (layout). Called after initialization.
    /// Default implementation does nothing.
    open func setupSubviews() {

    }
}
