//
//  InputCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

protocol InputCellDelegate: AnyObject {
    func changeName(_ name: String)
    func changeEmail(_ email: String)
}

class InputCell: UITableViewCell, UITextFieldDelegate {
    
    private weak var delegate: InputCellDelegate? = nil
    
    func subscribe(_ delegate: InputCellDelegate) {
        self.delegate = delegate
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        textField.title = "Title"
        textField.textColor = .white
        textField.selectedTitleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
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
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(64)
        }
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        
        switch textField.placeholder {
        case "Name":
            self.delegate?.changeName(text)
            textField.text = ""
        case "Email":
            self.delegate?.changeEmail(text)
            textField.text = ""
        default:
            return true
        }
        
        return true
    }
}

extension InputCell {
    struct Item {
        let placeholder: String
    }
    
    func configure(_ item: Item) {
        textField.title = item.placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: item.placeholder,
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
    }
}
