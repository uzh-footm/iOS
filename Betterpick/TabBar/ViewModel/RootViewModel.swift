//
//  RootViewModel.swift
//  Betterpick
//
//  Created by David Bielik on 29/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import Foundation

class RootViewModel: SimpleFetchingViewModel<LeagueAndNationalityData> {

    // MARK: - Properties
    var onDataLoaded: ((LeagueAndNationalityData) -> Void)?

    // MARK: - Inherited
    override func startFetching(completion: @escaping BetterpickAPIManager.Callback<LeagueAndNationalityData>) {
        let requests = DispatchGroup()
        var leagues: [League]?
        var nationalities: [Nationality]?
        var leaguesError: Error?
        var nationalitiesError: Error?
        // '/leagues'
        requests.enter()
        apiManager.leagues { result in
            defer { requests.leave() }
            switch result {
            case .error(let error, _):
                leaguesError = error
            case .success(let leaguesBody):
                leagues = leaguesBody
            }
        }
        // '/nationalities'
        requests.enter()
        apiManager.nationalities { result in
            defer { requests.leave() }
            switch result {
            case .error(let error, _):
                nationalitiesError = error
            case .success(let nationalitiesBody):
                nationalities = nationalitiesBody
            }
        }

        requests.notify(queue: .global(qos: .default)) { [weak self] in
            DispatchQueue.main.async {
                guard let leagues = leagues else {
                    if let error = leaguesError {
                        self?.state = .error(error)
                    }
                    return
                }
                guard let nationalities = nationalities else {
                    if let error = nationalitiesError {
                        self?.state = .error(error)
                    }
                    return
                }
                self?.state = .displaying(LeagueAndNationalityData(leagues: leagues, nationalities: nationalities))
            }
        }
    }

    override func onFinishedInitialFetching(model: LeagueAndNationalityData) {
        onDataLoaded?(model)
    }
}
