//
//  SettingsViewController.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let appIconImageView = UIImageView(image: #imageLiteral(resourceName: "player_default_photo"))
    
    let versionLabel = UILabel(style: .secondary)
    
    lazy var creditsLabel: TappableLabel = {
        let label = TappableLabel()
        label.set(style: .creditsLabel)
        let hyperText = "David, Lundrim and Riki"
        let text = "Made with 💚 by \(hyperText)"
        label.set(hypertext: hyperText, in: text)
        label.onHypertextTapped = {
            UIApplication.shared.open(Config.creditsURL)
        }
        label.alpha = 0.8
        return label
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .compatibleSystemBackground

        setupSubviews()
        updateViewAppearance()
    }

    private func setupSubviews() {
        view.add(subview: appIconImageView)
        appIconImageView.widthAnchor.constraint(equalToConstant: Size.Image.bigPlayerPhoto).isActive = true
        appIconImageView.heightAnchor.constraint(equalTo: appIconImageView.widthAnchor).isActive = true
        appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Size.doubleStandardMargin).isActive = true

        view.add(subview: versionLabel)
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: Size.standardMargin).isActive = true
        
        view.add(subview: creditsLabel)
        creditsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        creditsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Size.doubleStandardMargin).isActive = true
    }
    
    private func updateViewAppearance() {
        let version = Config.appVersion
        let buildNumber = Config.buildNumber
        versionLabel.text = "Version: \(version) (\(buildNumber))"
    }
}
