//
//  PlayerPreviewTableViewCell.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerPreviewTableViewCell: UITableViewCell, Reusable {
    // MARK: - Properties
    // MARK: Static
    static let reuseIdentifier = "PlayerPreviewTableViewCell"

    // MARK: Views
    let playerPhotoImageView = RoundedImageView()
    let playerNameLabel = UILabel(style: .cellPrimary)
    let overallValueLabel = OverallValueLabel()
    let playerDataStackView = PlayerPreviewDataStackView()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Inherited
    func setup() {
        if #available(iOS 13, *) {} else {
            contentView.layoutMargins = UIEdgeInsets(top: Size.Cell.verticalMargin, left: Size.Cell.extendedSideMargin, bottom: Size.Cell.verticalMargin, right: 0)
        }
        accessoryType = .disclosureIndicator
        backgroundColor = .background
        playerPhotoImageView.contentMode = .scaleAspectFit
        layout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        playerPhotoImageView.sd_cancelCurrentImageLoad()
    }

    // MARK: Private
    private func layout() {
        contentView.add(subview: playerPhotoImageView)
        playerPhotoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        playerPhotoImageView.heightAnchor.constraint(equalToConstant: Size.Image.playerPhoto).isActive = true
        playerPhotoImageView.widthAnchor.constraint(equalTo: playerPhotoImageView.heightAnchor).isActive = true
        // To make automatic dimension row height on the tableview work correctly
        let imageTopConstraint: NSLayoutConstraint
        let imageBottomConstraint: NSLayoutConstraint
        if #available(iOS 13, *) {
            imageTopConstraint = playerPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.Cell.verticalMargin)
            imageBottomConstraint = playerPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Size.Cell.verticalMargin)
        } else {
            imageTopConstraint = playerPhotoImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
            imageBottomConstraint = playerPhotoImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        }
        imageTopConstraint.priority = UILayoutPriority(rawValue: 999)
        imageTopConstraint.isActive = true
        imageBottomConstraint.isActive = true

        // OVR label
        contentView.add(subview: overallValueLabel)
        overallValueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        overallValueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true

        // Label + Data container
        let labelAndDataContainerView = UIView()
        contentView.add(subview: labelAndDataContainerView)
        labelAndDataContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelAndDataContainerView.leadingAnchor.constraint(equalTo: playerPhotoImageView.trailingAnchor, constant: Size.Cell.extendedSideMargin/2).isActive = true
        labelAndDataContainerView.trailingAnchor.constraint(equalTo: overallValueLabel.leadingAnchor, constant: -Size.standardMargin).isActive = true

        // Player Name label
        labelAndDataContainerView.add(subview: playerNameLabel)
        playerNameLabel.embedSides(in: labelAndDataContainerView)
        playerNameLabel.topAnchor.constraint(equalTo: labelAndDataContainerView.topAnchor).isActive = true

        // Player Data stack view
        labelAndDataContainerView.add(subview: playerDataStackView)
        playerDataStackView.embedSides(in: labelAndDataContainerView)
        playerDataStackView.bottomAnchor.constraint(equalTo: labelAndDataContainerView.bottomAnchor).isActive = true

        playerDataStackView.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor).isActive = true
    }

    // MARK: - Public
    public func configure(from playerPreview: PlayerPreview, context: PlayerPreviewDisplayContext = []) {
        playerNameLabel.text = playerPreview.name
        // StackView
        var stackViewTextData = [String]()
        if context.contains(.showsExactPosition) {
            stackViewTextData.append(playerPreview.position.rawValue)
        }
        if context.contains(.showsClub) {
            stackViewTextData.append(playerPreview.club)
        }
        if context.contains(.showsNationality) {
            stackViewTextData.append(playerPreview.nation)
        }
        playerDataStackView.textData = stackViewTextData
        // OVR
        overallValueLabel.isHidden = !context.contains(.showsOvr)
        if context.contains(.showsOvr) {
            overallValueLabel.ovr = playerPreview.ovr
        }
        // Image
        playerPhotoImageView.sd_setImage(with: playerPreview.photoURL, placeholderImage: #imageLiteral(resourceName: "baseline_settings_black_48pt"), options: [], completed: nil)
    }
}
