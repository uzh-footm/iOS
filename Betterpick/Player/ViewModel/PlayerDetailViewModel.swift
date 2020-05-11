//
//  PlayerDetailViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 27/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

enum PlayerDetailSection: CaseIterable, CustomStringConvertible {
    case team
    // FIXME: Add additional info
    //case additionalInfo
    case skillSection(category: SkillSectionCategory)

    enum SkillSectionCategory: String, CaseIterable {
        case attacking
        case ball
        case movement
        case power
        case mentality
        case defending
        case goalkeeping

        var categoryText: String {
            switch self {
            case .attacking, .ball, .defending, .goalkeeping:
                return rawValue.capitalized + " skills"
            default:
                return rawValue.capitalized
            }
        }
    }

    static var allCases: [PlayerDetailSection] {
        let skillSections = SkillSectionCategory.allCases.map { PlayerDetailSection.skillSection(category: $0) }
        // FIXME: add additionalInfo
        //return [.team, .additionalInfo] + skillSections
        return [.team] + skillSections
    }

    var description: String {
        switch self {
        case .team: return "Club"
        //case .additionalInfo: return "Player Information"
        case .skillSection(let category): return category.categoryText
        }
    }
}

struct PlayerDetailModel: Decodable {
    let player: Player
    let club: TeamPreview
}

class PlayerDetailViewModel: SimpleFetchingViewModel<PlayerDetailModel> {

    // MARK: - Properties
    let playerPreview: PlayerPreview
    let nationalities: [Nationality]

    // MARK: - Initialization
    init(playerPreview: PlayerPreview, nationalities: [Nationality], apiManager: BetterpickAPIManager = BetterpickAPIManagerFactory.createAPIManager()) {
        self.playerPreview = playerPreview
        self.nationalities = nationalities
        super.init(apiManager: apiManager)
    }

    // MARK: - Inherited
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<PlayerDetailModel>) {
        let requests = DispatchGroup()
        var player: Player?
        var club: TeamPreview?
        var playerError: Error?
        var clubError: Error?

        requests.enter()
        apiManager.player(playerID: playerPreview.playerId) { result in
            defer { requests.leave() }
            switch result {
            case .error(let error):
                playerError = error
            case .success(let playerBody):
                player = playerBody
            }
        }

        requests.enter()
        apiManager.club(clubID: playerPreview.club) { result in
            defer { requests.leave() }
            switch result {
            case .error(let error):
                clubError = error
            case .success(let clubBody):
                club = clubBody
            }
        }

        requests.notify(queue: .global(qos: .default)) { [weak self] in
            DispatchQueue.main.async {
                guard let player = player else {
                    if let error = playerError {
                        self?.state = .error(error)
                    }
                    return
                }
                guard let club = club else {
                    if let error = clubError {
                        self?.state = .error(error)
                    }
                    return
                }
                self?.state = .displaying(PlayerDetailModel(player: player, club: club))
            }
        }
    }

    // MARK: - Public
    // MARK: Sections
    public func numberOfSections() -> Int {
        guard case .displaying = state else { return 0 }
        return PlayerDetailSection.allCases.count
    }

    public func getSection(at sectionIndex: Int) -> PlayerDetailSection {
        return PlayerDetailSection(from: sectionIndex)
    }

    public func titleFor(section: Int) -> String {
        let section = getSection(at: section)
        return section.description.uppercased()
    }

    public func numberOfRows(at sectionIndex: Int) -> Int {
        guard case .displaying = state else { return 0 }
        let section = getSection(at: sectionIndex)
        switch section {
        case .team:
            return 1
        case .skillSection(let category):
            return skillsFor(sectionCategory: category).count
        }
    }

    // MARK: Skills Sections
    public func skillsFor(sectionCategory: PlayerDetailSection.SkillSectionCategory) -> [(String, Int)] {
        guard case .displaying(let model) = state else { return [] }
        let player = model.player
        switch sectionCategory {
        case .attacking: return player.createNameValuePairs(keyPaths: Player.attackingSkillKeyPaths)
        case .ball: return player.createNameValuePairs(keyPaths: Player.ballSkillSkillKeyPaths)
        case .defending: return player.createNameValuePairs(keyPaths: Player.defendingSkillKeyPaths)
        case .goalkeeping: return player.createNameValuePairs(keyPaths: Player.goalkeepingSkillKeyPaths)
        case .mentality: return player.createNameValuePairs(keyPaths: Player.mentalitySkillKeyPaths)
        case .movement: return player.createNameValuePairs(keyPaths: Player.movementSkillKeyPaths)
        case .power: return player.createNameValuePairs(keyPaths: Player.powerSkillKeyPaths)
        }
    }

    public func skillDataFor(category: PlayerDetailSection.SkillSectionCategory, at row: Int) -> (String, Int) {
        return skillsFor(sectionCategory: category)[row]
    }

    public func nationalityURL() -> URL? {
        guard let model = model else { return nil }
        let nation = nationalities.first { $0.name == model.player.nationality }
        return nation?.logoURL
    }
}
