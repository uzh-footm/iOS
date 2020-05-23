//
//  FetchingView.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class FetchingView: ConstrainableView {

    // MARK: - Properties
    // MARK: Views
    let spinnerView: UIActivityIndicatorView = {
        let spinner: UIActivityIndicatorView
        if #available(iOS 13, *) {
            spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = .tertiaryLabel
        } else {
            spinner = UIActivityIndicatorView(style: .gray)
        }
        return spinner
    }()

    // MARK: - Inherited
    override func setupSubviews() {
        layout()
        backgroundColor = .compatibleSystemBackground
        spinnerView.startAnimating()
    }

    private func layout() {
        add(subview: spinnerView)
        spinnerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinnerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
