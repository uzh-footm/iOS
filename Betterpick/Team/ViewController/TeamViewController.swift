//
//  TeamViewController.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TeamViewController: VMViewController<TeamViewModel>, NavigationBarDisplaying, FetchingStatePresenting {

    // MARK: - Properties
    weak var playerSelectingCoordinator: PlayerSelecting?

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateView: FetchingView?
    var fetchingStateSuperview: UIView { return view }

    // MARK: UI
    let teamNameLabel: UILabel = {
        let label = UILabel(style: .title)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        return label
    }()

    let teamLogoImageView = UIImageView()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .compatibleSystemGroupedBackground
        table.contentInset.top = Size.TableView.headerHeight
        // Removes tableFooterView
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.5))
        table.sectionFooterHeight = Size.TableView.headerHeight
        table.register(reusableHeaderFooter: PositionSectionHeaderView.self)
        table.register(reusableCell: PlayerPreviewTableViewCell.self)
        return table
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .compatibleSystemBackground
        teamLogoImageView.contentMode = .scaleAspectFit
        hideBackBarButtonText()

        setupSubviews()

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance
        viewModel.start()

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func setupSubviews() {
        // Label
        view.add(subview: teamNameLabel)
        teamNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        teamNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Size.standardMargin).isActive = true

        // Logo
        view.add(subview: teamLogoImageView)
        teamLogoImageView.bottomAnchor.constraint(equalTo: teamNameLabel.bottomAnchor).isActive = true
        teamLogoImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        teamLogoImageView.widthAnchor.constraint(equalToConstant: Size.Image.bigTeamLogo).isActive = true
        teamLogoImageView.heightAnchor.constraint(equalTo: teamLogoImageView.widthAnchor).isActive = true

        teamNameLabel.trailingAnchor.constraint(equalTo: teamLogoImageView.leadingAnchor, constant: -Size.standardMargin).isActive = true

        // TableView
        view.add(subview: tableView)
        tableView.embedSides(in: view)
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: Size.standardMargin).isActive = true

        // Separator
        let separator = HairlineView()
        view.add(subview: separator)
        separator.embedSides(in: view)
        separator.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    }

    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .fetching:
            addFetchingStateView()
        case .displaying(let model):
            teamLogoImageView.sd_setImage(with: model.logoURL, placeholderImage: nil, options: [], context: nil)
            teamNameLabel.text = model.name
            removeFetchingStateView()
            tableView.reloadData()
        case .error(let error):
            addFetchingStateView()
            showErrorState(error: error)
        }
    }
}
