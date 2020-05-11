//
//  TabBarViewController.swift
//  Betterpick
//
//  Created by David Bielik on 13/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {

    // MARK: - Properties
    // MARK: ViewModel
    let viewModel: TabBarViewModel

    // MARK: Delegate
    weak var delegate: TabBarViewControllerDelegate?

    // MARK: Views
    // UIView for the child view controllers (selected tabs)
    let containerView = UIView()

    lazy var tabBarStackView: TabBarStackView = {
        let stackView = TabBarStackView(tabs: viewModel.tabs)
        stackView.onButtonTapAction = handleTabBarButtonPress
        return stackView
    }()

    // MARK: - Initialization
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        // Update appearance and notify delegate when the tab changes
        viewModel.onTabChange = { [unowned self] tab in
            self.updateAppearance(with: tab)
            self.delegate?.didSelect(tab: tab)
        }

        // Notify delegate if the tab gets reselected
        viewModel.onTabReselect = { [unowned self] tab in
            self.delegate?.didReselect(tab: tab)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        prepareViewModel()
        updateTabBarStackViewSize()
    }

    // MARK: - Private
    private func prepareViewModel() {

    }

    // MARK: Layout
    private func layout() {
        // child vc (tab) container
        view.add(subview: containerView)
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        // stackview container
        let buttonsContainerView = UIView()
        buttonsContainerView.backgroundColor = .compatibleSystemBackground
        view.add(subview: buttonsContainerView)
        buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonsContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Size.Tab.height).isActive = true

        // stackview view
        view.add(subview: tabBarStackView)
        tabBarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabBarStackView.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor).isActive = true

        // separator
        let hairlineView = HairlineView()
        view.addSubview(hairlineView)
        hairlineView.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor).isActive = true
        hairlineView.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor).isActive = true
        hairlineView.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor).isActive = true
    }

    // MARK: Appearance
    private func updateAppearance(with tab: Tab) {
        guard let tabIndex = viewModel.tabs.firstIndex(of: tab) else { return }
        tabBarStackView.updateAppearance(selectedIndex: tabIndex)
    }

    private func updateTabBarStackViewSize() {
        let imageWidth = Size.Image.tabBarIcon
        let width = UIScreen.main.bounds.width
        let numberOfTabs = CGFloat(viewModel.tabs.count)
        let horizontalInset = ((width / numberOfTabs) - imageWidth) / 2
        let insets = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        tabBarStackView.arrangedSubviews.forEach { ($0 as? UIButton)?.imageEdgeInsets = insets }
    }

    // MARK: Touch Events
    private func handleTabBarButtonPress(tag: Int) {
        let selectedTab = viewModel.tabs[tag]
        viewModel.updateTab(to: selectedTab)
    }
}
