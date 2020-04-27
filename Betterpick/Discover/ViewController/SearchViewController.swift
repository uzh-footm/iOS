//
//  SearchViewController.swift
//  Betterpick
//
//  Created by David Bielik on 19/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

struct SearchResult: Decodable {
    let players: [PlayerPreview]?
    let clubs: [TeamPreview]?

    /// - returns: the number of result sections. Possible values are: { 0, 1, 2 }
    func numberOfResults() -> Int {
        var count = 0
        if clubs != nil {
            count += 1
        }
        if players != nil {
            count += 1
        }
        return count
    }
}

class SearchViewModel {

    enum SearchResultSection: Int, CustomStringConvertible {
        case clubs
        case players

        var description: String {
            switch self {
            case .clubs: return "Clubs"
            case .players: return "Players"
            }
        }
    }

    // MARK: - Properties
    let apiManager: BetterpickAPIManager
    var searchText: String = ""
    var searchResult: SearchResult? { didSet { onSearchResultUpdate?() } }

    // MARK: Actions
    var onSearchResultUpdate: (() -> Void)?

    // MARK: - Initialization
    init(apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.apiManager = apiManager
    }

    // MARK: - Public
    func searchPlaceholderText() -> String {
        return "e.g. Messi, Manchester ..."
    }

    func search() {
        let currentSearchText = searchText
        apiManager.search(name: searchText) { [weak self] result in
            guard let strongSelf = self, strongSelf.searchText == currentSearchText else { return }
            guard case .success(let searchResult) = result else { return }
            strongSelf.searchResult = searchResult
        }
    }

    func numberOfSections() -> Int {
        guard searchResult != nil else { return 0 }
        return 2
    }

    func playerPreview(at row: Int) -> PlayerPreview? {
        guard let searchResult = searchResult, let players = searchResult.players else { return nil }
        return players[row]
    }

    func clubPreview(at row: Int) -> TeamPreview? {
        guard let searchResult = searchResult, let clubs = searchResult.clubs else { return nil }
        return clubs[row]
    }

    func previews(at section: Int) -> [Decodable]? {
        guard let searchResult = searchResult else { return nil }
        let section = SearchResultSection(rawValue: section) ?? .clubs
        switch section {
        case .clubs: return searchResult.clubs
        case .players: return searchResult.players
        }
    }

    func previews(at indexPath: IndexPath) -> Decodable? {
        return previews(at: indexPath.section)?[indexPath.row]
    }

    func titleFor(section: Int) -> String {
        return (SearchResultSection(rawValue: section) ?? .clubs).description
    }
}

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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.previews(at: indexPath)
        if let player = model as? PlayerPreview {
            selectingCoordinator?.select(player: player)
        } else if let club = model as? TeamPreview {
            selectingCoordinator?.select(team: club)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.previews(at: section)?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < viewModel.numberOfSections() else { return nil }
        return viewModel.titleFor(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
