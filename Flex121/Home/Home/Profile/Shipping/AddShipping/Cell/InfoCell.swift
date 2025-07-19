//
//  InfoCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class InfoCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let textField: BaseTextField = {
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
