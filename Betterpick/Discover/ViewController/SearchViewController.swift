//
//  SearchViewController.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    // MARK: UI
    lazy var searchTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setPlaceholder(text: "e.g. Messi, Manchester ...")
        return textField
    }()

    lazy var backButton: ActionButton = {
        let backButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "chevron_left"))
        backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        return backButton
    }()

    // MARK: Actions
    var onFinishedSearching: (() -> Void)?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background

        setupSubviews()

        // Open the keyboard right away
        searchTextField.becomeFirstResponder()
    }

    // MARK: - Private
    private func setupSubviews() {
        // Fake navbar for autolayout centering
        let fakeNavigationBar = UIView()
        fakeNavigationBar.isUserInteractionEnabled = false
        view.add(subview: fakeNavigationBar)
        fakeNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        fakeNavigationBar.heightAnchor.constraint(equalToConstant: Size.Navigator.height).isActive = true
        fakeNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fakeNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        // Separator
        let separator = HairlineView()
        view.add(subview: separator)
        separator.leadingAnchor.constraint(equalTo: fakeNavigationBar.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: fakeNavigationBar.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: fakeNavigationBar.bottomAnchor).isActive = true

        // Back button
        view.add(subview: backButton)
        backButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: fakeNavigationBar.centerYAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: Size.smallerIconSize).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true

        // TextField
        view.add(subview: searchTextField)
        searchTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: Size.standardMargin).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: fakeNavigationBar.centerYAnchor).isActive = true
    }

    // MARK: Event Handling
    @objc private func didPressBackButton() {
        // Dismiss the keyboard
        searchTextField.resignFirstResponder()
        // Notify the action handler
        onFinishedSearching?()
    }
}
