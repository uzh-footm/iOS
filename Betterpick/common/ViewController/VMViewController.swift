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

extension VMViewController where ViewModel: FetchingViewModelProtocol {

    func showErrorState(error: BetterpickAPIError) {
        let errorAlert = UIAlertController(title: "Network Error", message: error.userFriendlyMessage, preferredStyle: .alert)

        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            self?.viewModel.start()
        }))

        present(errorAlert, animated: true, completion: nil)
    }
}
