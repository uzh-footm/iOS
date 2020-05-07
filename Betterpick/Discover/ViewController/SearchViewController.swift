//
//  SearchViewController.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SearchViewController: VMViewController<SearchViewModel> {

    // MARK: - Properties
    weak var selectingCoordinator: (TeamSelecting & PlayerSelecting)?

    // MARK: UI
    lazy var searchTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.addTarget(self, action: #selector(didChangeSearchTextField), for: .editingChanged)
        return textField
    }()

    lazy var backButton: ActionButton = ActionButton.createActionButton(image: #imageLiteral(resourceName: "chevron_left"), target: self, action: #selector(didPressBackButton))

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .background
        table.sectionFooterHeight = Size.TableView.headerHeight
        table.contentInset.top = Size.TableView.headerHeight
        table.register(cells: [PlayerPreviewTableViewCell.self, TeamTableViewCell.self])
        table.register(reusableHeaderFooter: SearchResultSectionHeaderView.self)
        return table
    }()

    // MARK: Actions
    var onFinishedSearching: (() -> Void)?

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
            self?.tableView.reloadData()
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
        view.add(subview: tableView)
        tableView.embedSides(in: view)
        tableView.topAnchor.constraint(equalTo: fakeNavigationBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Separator
        let separator = HairlineView()
        view.add(subview: separator)
        separator.leadingAnchor.constraint(equalTo: fakeNavigationBar.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: fakeNavigationBar.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
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
