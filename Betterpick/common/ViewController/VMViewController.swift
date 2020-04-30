//
//  VMViewController.swift
//  Betterpick
//
//  Created by David Bielik on 29/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// ViewController base class with dependency injection for a generic ViewModel
class VMViewController<ViewModel>: UIViewController {

    let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("VMViewController init from coder not implemented") }
}
