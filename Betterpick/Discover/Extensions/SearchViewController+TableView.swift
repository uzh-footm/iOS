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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeue(headerFooter: SearchResultSectionHeaderView.self) else { return nil }
        header.text = viewModel.titleFor(section: section)
        header.results = tableView.numberOfRows(inSection: section)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Size.TableView.headerHeight
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.previews(at: indexPath)
        if let player = model as? PlayerPreview, let cell = tableView.dequeue(reusableCell: PlayerPreviewTableViewCell.self, for: indexPath) {
            cell.configure(from: player)
            return cell
        }

        if let club = model as? TeamPreview, let cell = tableView.dequeue(reusableCell: TeamTableViewCell.self, for: indexPath) {
            cell.configure(from: club)
            return cell
        }
        return UITableViewCell()
    }
}
