//
//  SettingsCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/15/25.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private let backgroundSettingsView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitle"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronRight
        return imageView
    }()
    
    private let mainStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.addSubview(backgroundSettingsView)
        backgroundSettingsView.addSubview(mainStackView)
        backgroundSettingsView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        [textStackView, chevronIcon].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(11)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        backgroundSettingsView.snp.makeConstraints { make in
            make.height.equalTo(65)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SettingsCell {
    struct Item {
        let title: String
        let subtitle: String
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
