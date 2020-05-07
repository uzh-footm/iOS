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
    let playerPhotoImageView = UIImageView()
    let playerNameLabel = UILabel(style: .cellTitle)

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
            contentView.layoutMargins = UIEdgeInsets(top: Size.Cell.narrowVerticalMargin, left: Size.Cell.extendedSideMargin, bottom: Size.Cell.narrowVerticalMargin, right: 0)
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
        playerPhotoImageView.heightAnchor.constraint(equalToConstant: Size.Image.teamLogo).isActive = true
        playerPhotoImageView.widthAnchor.constraint(equalTo: playerPhotoImageView.heightAnchor).isActive = true
        // To make automatic dimension row height on the tableview work correctly
        let imageTopConstraint: NSLayoutConstraint
        let imageBottomConstraint: NSLayoutConstraint
        if #available(iOS 13, *) {
            imageTopConstraint = playerPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.Cell.narrowVerticalMargin)
            imageBottomConstraint = playerPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Size.Cell.narrowVerticalMargin)
        } else {
            imageTopConstraint = playerPhotoImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
            imageBottomConstraint = playerPhotoImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        }
        imageTopConstraint.priority = UILayoutPriority(rawValue: 999)
        imageTopConstraint.isActive = true
        imageBottomConstraint.isActive = true

        contentView.add(subview: playerNameLabel)
        playerNameLabel.leadingAnchor.constraint(equalTo: playerPhotoImageView.trailingAnchor, constant: Size.Cell.extendedSideMargin/2).isActive = true
        playerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        playerNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    }

    // MARK: - Public
    public func configure(from playerPreview: PlayerPreview) {
        playerNameLabel.text = playerPreview.name
        playerPhotoImageView.sd_setImage(with: playerPreview.photoURL, placeholderImage: #imageLiteral(resourceName: "baseline_settings_black_48pt"), options: [], completed: nil)
    }
}
