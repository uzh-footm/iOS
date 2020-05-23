//
//  TeamTableViewCell.swift
//  Betterpick
//
//  Created by David Bielik on 22/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit
import SDWebImage

class TeamTableViewCell: UITableViewCell, Reusable {
    // MARK: - Properties
    // MARK: Static
    static let reuseIdentifier = "TeamTableViewCell"

    // MARK: Views
    let teamLogoImageView = UIImageView()
    let teamNameLabel = UILabel(style: .cellPrimary)

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Inherited
    func setup() {
        if #available(iOS 13, *) {} else {
            contentView.layoutMargins = UIEdgeInsets(top: Size.Cell.verticalMargin, left: Size.Cell.extendedSideMargin, bottom: Size.Cell.verticalMargin, right: 0)
        }
        accessoryType = .disclosureIndicator
        backgroundColor = .compatibleSecondarySystemGroupedBackground
        teamLogoImageView.contentMode = .scaleAspectFit
        layout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        teamLogoImageView.sd_cancelCurrentImageLoad()
    }

    // MARK: Private
    private func layout() {
        contentView.add(subview: teamLogoImageView)
        teamLogoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        let teamLogoHeightConstraint = teamLogoImageView.heightAnchor.constraint(equalToConstant: Size.Image.teamLogo)
        // This line makes sure that we prioritize the cellHeightForRow height over this height constant...
        teamLogoHeightConstraint.priority = .init(900)
        teamLogoHeightConstraint.isActive = true
        teamLogoImageView.widthAnchor.constraint(equalTo: teamLogoImageView.heightAnchor).isActive = true
        // To make automatic dimension row height on the tableview work correctly
        let imageTopConstraint: NSLayoutConstraint
        let imageBottomConstraint: NSLayoutConstraint
        if #available(iOS 13, *) {
            imageTopConstraint = teamLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.Cell.verticalMargin)
            imageBottomConstraint = teamLogoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Size.Cell.verticalMargin)
        } else {
            imageTopConstraint = teamLogoImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
            imageBottomConstraint = teamLogoImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        }
        imageTopConstraint.priority = UILayoutPriority(rawValue: 999)
        imageTopConstraint.isActive = true
        imageBottomConstraint.isActive = true

        contentView.add(subview: teamNameLabel)
        teamNameLabel.leadingAnchor.constraint(equalTo: teamLogoImageView.trailingAnchor, constant: Size.Cell.extendedSideMargin/2).isActive = true
        teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        teamNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    }

    // MARK: - Public
    public func configure(from teamPreview: TeamPreview) {
        teamNameLabel.text = teamPreview.name
        teamLogoImageView.sd_setImage(with: teamPreview.actualLogo, placeholderImage: nil, options: [], completed: nil)
    }
}
