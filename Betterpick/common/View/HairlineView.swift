//
//  HairlineView.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class HairlineView: ConstrainableView {
    override func setupSubviews() {
        backgroundColor = .customOpaqueSeparator
        let height = HairlineView.minimalWidth
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    static var minimalWidth: CGFloat {
        return (1.0 / UIScreen.main.scale)
    }
}
