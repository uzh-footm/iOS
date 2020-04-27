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
    let viewModel: SearchViewModel
    weak var selectingCoordinator: (TeamSelecting & PlayerSelecting)?

    // MARK: UI
    lazy var searchTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.addTarget(self, action: #selector(didChangeSearchTextField), for: .editingChanged)
        return textField
    }()

    lazy var backButton: ActionButton = {
        let backButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "chevron_left"))
        backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        return backButton
    }()

    lazy var resultsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .background
        table.register(PlayerPreviewTableViewCell.self, forCellReuseIdentifier: PlayerPreviewTableViewCell.reuseIdentifier)
        return table
    }()

    // MARK: Actions
    var onFinishedSearching: (() -> Void)?

    // MARK: - Initialization
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background

        setupSubviews()

        searchTextField.setPlaceholder(text: viewModel.searchPlaceholderText())
        // Open the keyboard right away
        searchTextField.becomeFirstResponder()

        // ViewModel
        viewModel.onSearchResultUpdate = { [weak self] in
            self?.resultsTableView.reloadData()
        }
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

        // TableView
        view.add(subview: resultsTableView)
        resultsTableView.embedSides(in: view)
        resultsTableView.topAnchor.constraint(equalTo: fakeNavigationBar.bottomAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    // MARK: Event Handling
    @objc private func didChangeSearchTextField() {
        // Set the search text in the viewModel
        let newSearchText = searchTextField.text ?? ""
        viewModel.searchText = newSearchText
        // After 0.1 seconds call the method
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard self?.viewModel.searchText == newSearchText else { return }
            self?.viewModel.search()
        }
    }

    @objc private func didPressBackButton() {
        // Dismiss the keyboard
        searchTextField.resignFirstResponder()
        // Notify the action handler
        onFinishedSearching?()
    }
}
