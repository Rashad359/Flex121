//
//  PickerCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit
import SkyFloatingLabelTextField

class PickerCell: UITableViewCell {
    
    private var pickerItems: [String] = []
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.chevronDown)
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var picker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            .init(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(didTapDone)
            )
        ]
        return toolbar
    }()
    
    private lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        textField.textColor = .white
        textField.selectedTitleColor = .white
        textField.titleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Country",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.title = "Country"
        textField.rightViewMode = .always
        textField.rightView = chevronImageView
        return textField
    }()
    
    @objc
    private func didTapDone() {
        endEditing(true)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(textField)
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(66)
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension PickerCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerItems[row]
    }
}

extension PickerCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.chevronImageView.transform = self.chevronImageView.transform.rotated(by: .pi)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.chevronImageView.transform = self.chevronImageView.transform.rotated(by: .pi)
        }
    }
}

extension PickerCell {
    struct Item {
        let promptText: String
        let pickerData: [String]
    }
    
    func configure(_ item: Item) {
        textField.title = item.promptText
        textField.attributedPlaceholder = NSAttributedString(
            string: item.promptText,
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        pickerItems = item.pickerData
        picker.reloadAllComponents()
    }
}
