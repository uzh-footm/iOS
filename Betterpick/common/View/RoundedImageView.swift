//
//  RoundedImageView.swift
//  Betterpick
//
//  Created by David Bielik on 08/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Inherited
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }

    // MARK: - Private
    private func setup() {
        clipsToBounds = true
    }
}
