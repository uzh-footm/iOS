//
//  TeamListViewController+TableView.swift
//  Betterpick
//
//  Created by David Bielik on 26/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource
extension TeamListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTeams()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let teams = viewModel.currentLeague?.teams, let cell = tableView.dequeueReusableCell(withIdentifier: TeamListTableViewCell.reuseIdentifier, for: indexPath) as? TeamListTableViewCell else {
            return UITableViewCell()
        }
        let team = teams[indexPath.row]
        cell.configure(from: team)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let teams = viewModel.currentLeague?.teams else { return }
        coordinator?.select(team: teams[indexPath.row])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Animate the separator if needed
        separatorAnimator.handleScrollViewDidScroll(scrollView)
    }
}
