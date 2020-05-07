//
//  ToolbarPickerView.swift
//  Betterpick
//
//  Created by David Bielik on 01/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

/// UIPickerView with a dedicated Toolbar that contains 'Cancel' and 'Done' buttons.
class ToolbarPickerView: UIPickerView {

    // MARK: - Properties
    public private(set) var toolbar: UIToolbar?

    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

    public var title: String? {
        didSet {
            titleButton.title = title
        }
    }

    // MARK: Private
    private let titleButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    // MARK: - Private
    private func commonInit() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Size.toolbarHeight))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        toolBar.tintColor = .primary

        // Add Buttons
        titleButton.isEnabled = false
        titleButton.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .disabled)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.didTapDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.didTapCancel))
        toolBar.setItems([cancelButton, spaceButton, titleButton, spaceButton, doneButton], animated: false)

        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    // MARK: Event Handlers
    @objc private func didTapDone() {
        self.toolbarDelegate?.didTapDone(self)
    }

    @objc private func didTapCancel() {
        self.toolbarDelegate?.didTapCancel(self)
    }

    // MARK: - Public
    public func resetSelection(animated: Bool = false) {
        let row = 0
        let component = row
        selectRow(row, inComponent: component, animated: animated)
        delegate?.pickerView?(self, didSelectRow: row, inComponent: component)
    }
}
