//
//  PlayerDetailViewController.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    // MARK: - Properties
    let viewModel: PlayerDetailViewModel

    // MARK: - Initialization
    init(viewModel: PlayerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background

        viewModel.onStateUpdate = updateViewStateAppearance

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func updateViewStateAppearance() {
        title = viewModel.playerPreview.name
    }
}
