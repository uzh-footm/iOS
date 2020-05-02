//
//  PlayerFilterViewController.swift
//  Betterpick
//
//  Created by David Bielik on 30/04/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

class PlayerFilterViewController: VMViewController<PlayerFilterViewModel> {

    // MARK: - Properties
    var onFinishedFiltering: ((PlayerFilterData?) -> Void)?

    // MARK: Picker Handlers
    lazy var nationalityPickerHandler = NationalityPickerHandler(viewModel: viewModel, pickerView: nationalityPickerView)
    lazy var positionPickerHandler = PositionPickerHandler(viewModel: viewModel, pickerView: positionPickerView)

    // MARK: UI
    lazy var tableView: UITableView = {
        let style: UITableView.Style
        if #available(iOS 13.0, *) {
            style = .insetGrouped
        } else {
            style = .grouped
        }
        let tableView = UITableView(frame: .zero, style: style)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    lazy var nationalityPickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.title = "Nationality"
        return picker
    }()

    lazy var positionPickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.title = "Position"
        return picker
    }()

    // MARK: Private
    /// Tracks the last `selectedIndexPath` on the `tableView`
    var lastSelectedIndexPath: IndexPath?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .graySystemFill

        setupPickerViewHiding()

        setupNavBar()

        setupSubviews()
    }

    // MARK: - Private
    private func setupPickerViewHiding() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupNavBar() {
        // Buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.didPressDoneButton))
        doneButton.tintColor = .primary
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.didPressCancelButton))
        cancelButton.tintColor = .primary

        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton

        // Title
        title = "Player filters"
    }

    private func setupSubviews() {
        view.add(subview: tableView)
        tableView.embed(in: view)
    }

    // MARK: Event Handlers
    /// Dismisses the pickerView whenever the user taps outside of the pickerView bounds
    /// - note: if the user taps another PickerViewCell the pickerView is just replaced to avoid stuttering animations.
    @objc private func didTapView(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: tableView)
        if let indexPathOfTap = tableView.indexPathForRow(at: location), tableView.cellForRow(at: indexPathOfTap) as? PickerResponderTableViewCell != nil {
            return
        }
        view.endEditing(true)
    }

    @objc private func didPressDoneButton() {
        onFinishedFiltering?(viewModel.playerFilterData)
    }

    @objc private func didPressCancelButton() {
        onFinishedFiltering?(nil)
    }
}
