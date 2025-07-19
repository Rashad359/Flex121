//
//  ConfigCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

class ConfigCell: UITableViewCell {
    
    private let backView: UIView = {
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
    
    private let modeSwitch: UISwitch = {
        let modSwitch = UISwitch()
        modSwitch.setOn(true, animated: true)
        return modSwitch
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
    
    private let rightStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(mainStackView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        [titleLabel, rightStackView].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        [chevronIcon, modeSwitch].forEach(rightStackView.addArrangedSubview)
        chevronIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - tasks:
    //Implement name and email editing
    //Implement dark mode switching
}

extension ConfigCell {
    struct Item {
        let title: String
        let isSwitchShown: Bool
        let isChevronShown: Bool
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.title
        modeSwitch.isHidden = !item.isSwitchShown
        chevronIcon.isHidden = !item.isChevronShown
    }
}
