//
//  LargeNavigationBar.swift
//  Betterpick
//
//  Created by David Bielik on 25/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class LargeNavigationBar: UINavigationBar {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let items = items, items.count == 1 else {
            // Allow navbar interaction on pushed viewcontrollers
            return super.hitTest(point, with: event)
        }
        // Don't allow interaction on the navbar while we are showing only the rootViewController
        return nil
    }
}
