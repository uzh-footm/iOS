//
//  Tab.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

enum Tab: CaseIterable {
    case discover
    case myTeams
    case settings

    var image: UIImage {
        switch self {
        case .discover: return #imageLiteral(resourceName: "outline_dashboard_black_48pt")
        case .myTeams: return #imageLiteral(resourceName: "teams_48pt")
        case .settings: return #imageLiteral(resourceName: "outline_settings_black_48pt")
        }
    }

    var highlightedImage: UIImage {
        switch self {
        case .discover: return #imageLiteral(resourceName: "baseline_dashboard_black_48pt")
        case .myTeams: return #imageLiteral(resourceName: "teams_48pt")
        case .settings: return #imageLiteral(resourceName: "baseline_settings_black_48pt")
        }
    }
}

typealias Tabs = [Tab]
