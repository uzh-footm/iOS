//
//  SimpleFetchingViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

/// The resource that is fetched is already the model that we need.
/// Overrides (final) the `responseBodyToModel` function which returns the responseBody as the model.
class SimpleFetchingViewModel<Model: Decodable>: FetchingViewModel<Model, Model> {
    final override func responseBodyToModel(_ responseBody: Model) -> Model? {
        return responseBody
    }
}
