//
//  SearchViewController+TableView.swift
//  Betterpick
//
//  Created by David Bielik on 28/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.previews(at: indexPath)
        if let player = model as? PlayerPreview {
            selectingCoordinator?.select(player: player)
        } else if let club = model as? TeamPreview {
            selectingCoordinator?.select(team: club)
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.previews(at: section)?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < viewModel.numberOfSections() else { return nil }
        return viewModel.titleFor(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
