//
//  TabBarViewModelTests.swift
//  BetterpickTests
//
//  Created by David Bielik on 16/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import XCTest
@testable import Betterpick

class TabBarViewModelTests: XCTestCase {

    // MARK: - Properties
    var tabBarViewModel: TabBarViewModel {
        let dummyLeagueAndNationalityData = LeagueAndNationalityData(leagues: [], nationalities: [])
        return TabBarViewModel(data: dummyLeagueAndNationalityData)
    }

    // MARK: - Tests

    func testInitialValueNil() {
        let viewModel = tabBarViewModel

        XCTAssertNil(viewModel.currentTab)
    }

    func testTabsEqualsAllCases() {
        let viewModel = tabBarViewModel

        XCTAssert(viewModel.tabs == Tab.allCases)
    }

    func testUpdateTab() {
        let viewModel = tabBarViewModel

        let newTab = Tab.discover
        viewModel.updateTab(to: newTab)

        XCTAssert(viewModel.currentTab == newTab)
    }

    /// The VM should call the `onTabChange` closure whenever the tab value changes.
    func testTabChangeCallback() {
        let viewModel = tabBarViewModel

        let newTab = Tab.settings
        let newTabExpectation = expectation(description: "onTabChange should be called back with \(newTab)")
        viewModel.onTabChange = { callbackTab in
            if callbackTab == newTab {
                newTabExpectation.fulfill()
            }
        }
        viewModel.updateTab(to: newTab)

        wait(for: [newTabExpectation], timeout: 0.2)
    }

    /// The VM should call the `onTabReselect` closure whenever the tab value changes.
    func testTabReselectCallback() {
        let viewModel = tabBarViewModel

        let newTab = Tab.settings
        let reselectedTabExpectation = expectation(description: "onTabReselect should be called back with \(newTab)")
        viewModel.onTabReselect = { reselectedTab in
            if reselectedTab == newTab {
                reselectedTabExpectation.fulfill()
            }
        }

        viewModel.updateTab(to: newTab)
        viewModel.updateTab(to: newTab)
        wait(for: [reselectedTabExpectation], timeout: 0.2)
    }
}
