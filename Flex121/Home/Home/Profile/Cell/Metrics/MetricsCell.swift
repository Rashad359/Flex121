//
//  MetricsCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/15/25.
//

import UIKit

class MetricsCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private let titleNumber: UILabel = {
        let label = UILabel()
        label.text = "19"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .white
        return label
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .underline
        contentView.layer.cornerRadius = 8
        contentView.addSubview(textStackView)
        [titleLabel, titleNumber].forEach(textStackView.addArrangedSubview)
        textStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension MetricsCell {
    struct Item {
        let titleText: String
        let number: String
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.titleText
        titleNumber.text = item.number
    }
}
