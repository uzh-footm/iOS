//
//  BetterpickScreenshots.swift
//  BetterpickScreenshots
//
//  Created by David Bielik on 20/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import XCTest

class BetterpickScreenshots: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Discover - Teams
        XCUIApplication().segmentedControls.buttons["Teams"].tap()
        snapshot("01DiscoverTeamsScreen")

        // Team
        app.tables.cells.element(boundBy: 7).tap()
        snapshot("02TeamScreen")

        // Player
        app.tables.cells.element(boundBy: 2).tap()
        snapshot("03PlayerDetailScreen")
    }
}
