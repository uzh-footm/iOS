//
//  PlayerDetailViewController.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerSkillValueTableViewCell: UITableViewCell, Reusable {

    // MARK: - Properties
    static var reuseIdentifier: String = "PlayerSkillValueTableViewCell"

    // MARK: UI
    let ovrValueLabel = OverallValueLabel()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Private
    override func layoutSubviews() {
        super.layoutSubviews()
        // Removes the separator
        separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: bounds.width)
    }

    private func setup() {
        backgroundColor = .compatibleSystemBackground
        selectionStyle = .none
        textLabel?.set(style: .cellPrimary)

        setupSubviews()
    }

    private func setupSubviews() {
        contentView.add(subview: ovrValueLabel)
        ovrValueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        ovrValueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}

class PlayerDetailViewController: VMViewController<PlayerDetailViewModel>, NavigationBarDisplaying, FetchingStatePresenting {

    // MARK: - Properties
    weak var teamSelectingCoordinator: TeamSelecting?

    // MARK: UI
    let playerPhotoImageView = UIImageView()
    let nationalityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let playerFirstNameLabel = UILabel(style: .playerFirstName)
    let playerSurnameLabel = UILabel(style: .playerValueText)

    let playerOvrStaticInfoLabel: UILabel = {
        let label = UILabel(style: .playerStaticText)
        label.text = "OVR"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 1
        return label
    }()
    let playerOvrLabel = UILabel(style: .playerValueText)

    let coloredPositionLabel = ColoredPositionLabel(style: .playerValueText)

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .compatibleSystemGroupedBackground
        table.contentInset.top = Size.TableView.headerHeight
        // Removes tableFooterView
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.5))
        table.sectionFooterHeight = Size.TableView.headerHeight
        table.sectionHeaderHeight = Size.TableView.headerHeight
        table.register(cells: [TeamTableViewCell.self, PlayerSkillValueTableViewCell.self])
        table.register(reusableHeaderFooter: SectionHeaderView.self)
        return table
    }()

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateSuperview: UIView { return view }
    var fetchingStateView: FetchingView?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackBarButtonText()

        view.backgroundColor = .compatibleSystemBackground

        setupSubviews()

        // ViewModel
        viewModel.onStateUpdate = updateViewStateAppearance
        viewModel.start()

        updateViewStateAppearance()
    }

    // MARK: - Private
    private func setupSubviews() {
        // Images
        view.add(subview: playerPhotoImageView)
        playerPhotoImageView.heightAnchor.constraint(equalToConstant: Size.Image.bigPlayerPhoto).isActive = true
        playerPhotoImageView.widthAnchor.constraint(equalTo: playerPhotoImageView.heightAnchor).isActive = true
        playerPhotoImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: Size.standardMargin).isActive = true
        playerPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        view.add(subview: nationalityImageView)
        nationalityImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nationalityImageView.widthAnchor.constraint(equalTo: nationalityImageView.heightAnchor).isActive = true
        nationalityImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -Size.standardMargin).isActive = true
        nationalityImageView.topAnchor.constraint(equalTo: playerPhotoImageView.topAnchor).isActive = true

        // Name
        view.add(subview: playerFirstNameLabel)
        playerFirstNameLabel.leadingAnchor.constraint(equalTo: playerPhotoImageView.trailingAnchor, constant: Size.standardMargin).isActive = true
        playerFirstNameLabel.topAnchor.constraint(equalTo: playerPhotoImageView.topAnchor, constant: Size.standardMargin/4).isActive = true

        view.add(subview: playerSurnameLabel)
        playerSurnameLabel.leadingAnchor.constraint(equalTo: playerFirstNameLabel.leadingAnchor).isActive = true
        playerSurnameLabel.topAnchor.constraint(equalTo: playerFirstNameLabel.bottomAnchor).isActive = true

        // OVR
        view.add(subview: playerOvrLabel)
        playerOvrLabel.leadingAnchor.constraint(equalTo: playerFirstNameLabel.leadingAnchor).isActive = true
        playerOvrLabel.bottomAnchor.constraint(equalTo: playerPhotoImageView.bottomAnchor, constant: -Size.standardMargin/4).isActive = true

        view.add(subview: playerOvrStaticInfoLabel)
        playerOvrStaticInfoLabel.firstBaselineAnchor.constraint(equalTo: playerOvrLabel.topAnchor).isActive = true
        playerOvrStaticInfoLabel.embedSides(in: playerOvrLabel)

        // Position
        view.add(subview: coloredPositionLabel)
        coloredPositionLabel.leadingAnchor.constraint(equalTo: playerOvrLabel.trailingAnchor, constant: Size.extendedMargin).isActive = true
        coloredPositionLabel.firstBaselineAnchor.constraint(equalTo: playerOvrLabel.firstBaselineAnchor).isActive = true

        // TableView
        view.add(subview: tableView)
        tableView.embedSides(in: view)
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: playerPhotoImageView.bottomAnchor).isActive = true
        // Separator
        let tableViewSeparator = HairlineView()
        view.add(subview: tableViewSeparator)
        tableViewSeparator.embedSides(in: view)
        tableViewSeparator.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    }

    private func updateViewStateAppearance() {
        switch viewModel.state {
        case .fetching:
            addFetchingStateView()
        case .displaying(let model):
            let player = model.player
            removeFetchingStateView()
            tableView.reloadData()
            playerPhotoImageView.sd_setImage(with: viewModel.playerPreview.actualPhoto, placeholderImage: #imageLiteral(resourceName: "player_default_photo"))
            coloredPositionLabel.configure(from: player.position)
            playerOvrLabel.text = String(player.overall)
            playerFirstNameLabel.text = player.firstName
            playerSurnameLabel.text = player.surname
            nationalityImageView.sd_setImage(with: viewModel.nationalityURL(), placeholderImage: nil)
        case .error:
            addFetchingStateView()
        }
    }
}

extension PlayerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeue(headerFooter: SectionHeaderView.self) else { return nil }
        header.text = viewModel.titleFor(section: section)
        return header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.getSection(at: indexPath.section)
        switch section {
        case .team:
            return Size.Cell.teamHeight
        case .skillSection:
            return Size.Cell.height
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is TeamTableViewCell, let model = viewModel.model else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        teamSelectingCoordinator?.select(team: model.club)
    }
}

extension PlayerDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.getSection(at: indexPath.section)
        switch section {
        case .team:
            guard let teamCell = tableView.dequeue(reusableCell: TeamTableViewCell.self, for: indexPath), let model = viewModel.model else { return UITableViewCell() }
            teamCell.configure(from: model.club)
            return teamCell
        case .skillSection(let category):
            guard let cell = tableView.dequeue(reusableCell: PlayerSkillValueTableViewCell.self, for: indexPath) else { return UITableViewCell() }
            let (skillName, value) = viewModel.skillDataFor(category: category, at: indexPath.row)
            cell.backgroundColor = indexPath.row % 2 == 0 ? .compatibleSecondarySystemGroupedBackground : .backgroundAccent
            cell.textLabel?.text = skillName
            cell.ovrValueLabel.ovr = value
            return cell
        }
    }
}
