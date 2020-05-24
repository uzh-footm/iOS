//
//  URL+Append.swift
//  Betterpick
//
//  Created by David Bielik on 24/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

extension URL {
    @discardableResult
    func append(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        // create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // create query item if value is not nil
        guard let value = value else { return absoluteURL }
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // append the new query item in the existing query items array
        queryItems.append(queryItem)

        // append updated query items array in the url component object
        urlComponents.queryItems = queryItems// queryItems?.append(item)

        // returns the url from new url components
        return urlComponents.url ?? self
    }
}
