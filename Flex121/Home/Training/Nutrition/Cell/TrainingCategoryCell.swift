//
//  TrainingCategoryCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/23/25.
//

import UIKit

class TrainingCategoryCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .underline
        return view
    }()
    
    private let leftView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .openCyan
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Water"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .openCyan
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let amount: UILabel = {
        let label = UILabel()
        label.text = "0.9L(75%)"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended until now 1.4L"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var checkBox: CircularCheckbox = {
        let box = CircularCheckbox()
        box.layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        box.addGestureRecognizer(tapGesture)
        return box
    }()
    
    private let titleStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 3
        return stackView
    }()
    
    private let leftStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    @objc
    private func didTapCheck() {
        checkBox.toggle()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(backView)
        selectionStyle = .none
        
        [leftView, leftStackView, checkBox].forEach(backView.addSubview)
        
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
            make.height.equalTo(76)
        }
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalTo(leftView.snp.trailing).offset(18)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        [titleStackView, subtitleLabel].forEach(leftStackView.addArrangedSubview)
        
        [titleLabel, amount].forEach(titleStackView.addArrangedSubview)
        
        leftView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(16)
        }
        
        checkBox.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalToSuperview().offset(-18)
            make.top.bottom.equalToSuperview().inset(28)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


extension TrainingCategoryCell {
    struct Item {
        let mainColor: UIColor
        let titleText: String
        let amount: String
        let subtitle: String
    }
    
    func configure(_ item: Item) {
        leftView.backgroundColor = item.mainColor
        titleLabel.text = item.titleText
        titleLabel.textColor = item.mainColor
        amount.text = item.amount
        subtitleLabel.text = item.subtitle
    }
}
