//
//  ProgressCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/10/25.
//

import UIKit

class ProgressCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1200"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let metricLabel: UILabel = {
        let label = UILabel()
        label.text = "kcal"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let botStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .underline
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.orange.cgColor
        contentView.layer.cornerRadius = 24
        contentView.addSubview(mainStackView)
        [titleLabel, botStackView].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-23)
        }
        [amountLabel, metricLabel].forEach(botStackView.addArrangedSubview)
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(103)
            make.height.equalTo(92)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProgressCell {
    struct Item {
        let title: String
        let amount: String
        let measure: String
        let mainColor: UIColor
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.title
        amountLabel.text = item.amount
        metricLabel.text = item.measure
        contentView.layer.borderColor = item.mainColor.cgColor
        titleLabel.textColor = item.mainColor
        amountLabel.textColor = item.mainColor
        metricLabel.textColor = item.mainColor
    }
}
