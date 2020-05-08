//
//  PlayerFilterViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class PlayerFilterViewModel {

    // MARK: - Properties
    // MARK: Models
    var playerFilterData: PlayerFilterData
    let nationalities: [Nationality?]
    let positionComponentData = PositionComponentData()

    // MARK: Actions
    var onOvrRangeUpdate: (() -> Void)?

    // MARK: - Initialization
    init(playerFilterData: PlayerFilterData, nationalities: [Nationality]) {
        self.playerFilterData = playerFilterData
        self.nationalities = [Nationality].insertNilToCollection(nationalities)
    }

    // MARK: - Public
    public func resetFilterData() {
        playerFilterData = PlayerFilterData()
    }

    // MARK: Sections
    public func numberOfSections() -> Int {
        return PlayerFilterSection.allCases.count
    }

    public func section(at section: Int) -> PlayerFilterSection {
        return PlayerFilterSection(from: section)
    }

    // MARK: Rows
    public func numberOfRowsIn(section: Int) -> Int {
        let section = PlayerFilterSection(rawValue: section) ?? .sort
        switch section {
        case .sort: return PlayerFilterData.SortOrder.allCases.count
        case .playerInfo: return PlayerFilterSection.PlayerInformation.allCases.count
        case .reset: return 1
        }
    }

    // MARK: - Section: Sort Order
    public func getSortSectionData(at row: Int) -> (text: String, selected: Bool) {
        let sortOrder = PlayerFilterData.SortOrder.allCases[row]
        return (sortOrder.description, sortOrder == playerFilterData.sortOrder)
    }

    public func selectSortOrder(at row: Int) {
        if let newSortOrder = PlayerFilterData.SortOrder(rawValue: row) {
            playerFilterData.sortOrder = newSortOrder
        }
    }

    // MARK: - Section: Player Information
    public func getPlayerInfoSectionRow(at row: Int) -> PlayerFilterSection.PlayerInformation {
        return PlayerFilterSection.PlayerInformation.init(rawValue: row) ?? .nationality
    }

    public func detailTextForNationality() -> String {
        return playerFilterData.nationality?.name ?? "Any"
    }

    // MARK: Position
    public func detailTextForPosition() -> String {
        guard let position = playerFilterData.position else { return "Any" }
        if let exactPosition = playerFilterData.exactPosition {
            return exactPosition.rawValue
        } else if position == .goalkeeper {
            return position.positionText
        } else {
            return "Any \(position.positionText)"
        }
    }

    public func numberOfRowsInPositionPicker(component: Int, selectedPositionRow: Int) -> Int {
        let positions = positionComponentData.positions

        if component == 0 {
            return positions.count
        }

        let position = positions[selectedPositionRow]
        if component == 1 {
            return positionComponentData.exactPositions[position]?.count ?? 0
        }

        return 0
    }

    public func setPosition(from positionRow: Int, exactPositionRow: Int) {
        let position = positionComponentData.positions[positionRow]
        playerFilterData.position = position
        switch position {
        case .none:
            playerFilterData.exactPosition = nil
        case .some(let position):
            let exactPositions = positionComponentData.exactPositions[position]
            playerFilterData.exactPosition = exactPositions?[exactPositionRow]
        }
    }

    // MARK: Nationality
    public func setNationality(from nationalityRow: Int) {
        playerFilterData.nationality = nationalities[nationalityRow]
    }

    // MARK: OVR Range
    public func setOvrRange(_ lower: Double, _ upper: Double) {
        let minOvr = PlayerFilterData.minimumOvr
        let maxOvr = PlayerFilterData.maximumOvr
        let diff = abs(maxOvr - minOvr)
        let lowerOvr = minOvr + Int(lower * Double(diff))
        let upperOvr = minOvr + Int(upper * Double(diff))
        playerFilterData.ovrGreatherThanOrEqual = lowerOvr
        playerFilterData.ovrLessThanOrEqual = upperOvr
        onOvrRangeUpdate?()
    }

    public func ovrRangeText() -> String {
        return playerFilterData.ovrRangeText
    }
}
