//
//  InfoCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

protocol InfoCellDelegate: AnyObject {
    func addFullname(_ name: String)
    func addAddress(_ address: String)
    func addZipCode(_ zipCode: String)
}

class InfoCell: UITableViewCell, UITextFieldDelegate {
    
    private weak var delegate: InfoCellDelegate? = nil
    
    func subscribe(_ delegate: InfoCellDelegate) {
        self.delegate = delegate
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Full name"
        textField.textColor = .white
        textField.selectedTitleColor = .white
        textField.titleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Full name",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        
        return textField
    }()
    
    @objc
    private func didChangeText() {
        switch textField.placeholder {
        case "Full name":
            
            self.delegate?.addFullname(textField.text ?? "no name in didChange")
            
        case "Address":
            
            self.delegate?.addAddress(textField.text ?? "no address in didChange")
            
        case "Zip code(Postal Code)":
            
            self.delegate?.addZipCode(textField.text ?? "no zip code in didChange")
            
        default:
            return
        }
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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        switch textField.placeholder {
//        case "Full name":
//            
//            self.delegate?.addFullname(textField.text ?? "no name")
//            
//        case "Address":
//            
//            self.delegate?.addAddress(textField.text ?? "no address")
//            
//        case "Zip code(Postal Code)":
//            
//            self.delegate?.addZipCode(textField.text ?? "no zip code")
//            
//        default:
//            return true
//        }
//        
//        return true
//    }
}

extension InfoCell {
    struct Item {
        let title: String
    }
    
    func configure(_ item: Item) {
        textField.title = item.title
        textField.attributedPlaceholder = NSAttributedString(
            string: item.title,
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
    }
}
