//
//  Config.swift
//  Betterpick
//
//  Created by David Bielik on 22/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// Struct which provides the App configuration data such as version and build number.
struct Config {
    
    enum BundleKey: String {
        case appName = "CFBundleName"
        case appVersion = "CFBundleShortVersionString"
        case buildNumber = "CFBundleVersion"
    }
    
    static func variableFromMainBundle(key: BundleKey) -> String? {
        return Bundle.main.infoDictionary?[key.rawValue] as? String
    }
    
    /// The Application Name
    static let appName = variableFromMainBundle(key: .appName)!
    /// The Application Version
    static let appVersion = variableFromMainBundle(key: .appVersion)!
    /// The Build Number
    static let buildNumber = variableFromMainBundle(key: .buildNumber)!
    
    static let creditsURL = URL(string: "https://github.com/uzh-footm")!
}
