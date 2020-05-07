//
//  TeamViewController+TableView.swift
//  Betterpick
//
//  Created by David Bielik on 07/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate
extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let playerPreview = viewModel.player(at: indexPath) else { return }
        playerSelectingCoordinator?.select(player: playerPreview)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeue(headerFooter: SectionHeaderView.self) else { return nil }
        header.text = viewModel.titleForPosition(at: section)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Size.TableView.headerHeight
    }
}

// MARK: - UITableViewDataSource
extension TeamViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let squad = viewModel.getSquad() else { return 0 }
        return squad.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPlayersForPosition(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let player = viewModel.player(at: indexPath), let cell = tableView.dequeue(reusableCell: PlayerPreviewTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        cell.configure(from: player)
        return cell
    }
}
