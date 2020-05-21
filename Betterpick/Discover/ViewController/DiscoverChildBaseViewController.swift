//
//  DiscoverChildBaseViewController.swift
//  Betterpick
//
//  Created by David Bielik on 05/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class DiscoverChildBaseViewController<VM>: VMViewController<VM>, UITableViewDelegate {

    // MARK: - UI Elements
    let headerViewContainer: UIView = {
        let header = UIView()
        header.preservesSuperviewLayoutMargins = true
        return header
    }()

    let headerViewSeparator: HairlineView = {
        let sep = HairlineView()
        sep.alpha = 0
        return sep
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.removeLastSeparatorAndDontShowEmptyCells()
        tableView.backgroundColor = .compatibleSystemGroupedBackground
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()

    // MARK: Animation
    lazy var separatorAnimator: DiscoverTeamSeparatorAnimator = {
        let animator = DiscoverTeamSeparatorAnimator()
        animator.separator = self.headerViewSeparator
        return animator
    }()

    // MARK: FetchingStatePresenting
    typealias FetchingStateView = FetchingView
    var fetchingStateView: FetchingView?
    var fetchingStateSuperview: UIView { return tableView }

    // MARK: Cell Heights
    private var cellHeights: [IndexPath: CGFloat?] = [:]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    // MARK: - Private
    private func setupSubviews() {
        view.add(subview: headerViewContainer)
        headerViewContainer.embedSides(in: view)
        headerViewContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        headerViewContainer.heightAnchor.constraint(equalToConstant: Size.headerHeight).isActive = true
        setup(discoverHeaderView: headerViewContainer)

        // Table view
        view.add(subview: tableView)
        tableView.embedSides(in: view)
        tableView.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // League Info Label and TableView separator
        view.add(subview: headerViewSeparator)
        headerViewSeparator.embedSides(in: view)
        headerViewSeparator.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    }

    // MARK: - UITableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Animate the separator if needed
        separatorAnimator.handleScrollViewDidScroll(scrollView)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         cellHeights[indexPath] = cell.frame.height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellHeights[indexPath] {
            return height ?? UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }

    // These are required to be placed in this parent class because of this bug:
    // https://stackoverflow.com/questions/55393027/delegate-methods-in-child-class-sometimes-not-called-with-swift-5-compiler/55393950#55393950
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}

    // MARK: - Open
    /// Override this function to provide subviews and constraints for the header view container that sits at the top of the tableview
    open func setup(discoverHeaderView headerView: UIView) {

    }
}
