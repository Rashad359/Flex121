//
//  TitleCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

class TitleCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal Information"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .white
        return label
    }()
    
    private let editIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .edit
        return imageView
    }()
    
    private let mainStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(mainStackView)
        [titleLabel, editIcon].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(24)
        }
        editIcon.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleCell {
    struct Item {
        let title: String
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.title
    }
}
