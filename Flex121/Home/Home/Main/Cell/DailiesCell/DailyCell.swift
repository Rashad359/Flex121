//
//  DailyCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/10/25.
//

import UIKit

class DailyCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Breakfast"
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "450 Calories"
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let taskImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .apple
        return imageView
    }()
    
    private let dailyTime: UILabel = {
        let label = UILabel()
        label.text = "9:00 am"
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .cyan
        contentView.layer.cornerRadius = 16
        contentView.addSubview(mainStackView)
        [titleLabel, caloriesLabel, imageStackView, dailyTime].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        [emptyView, taskImage].forEach(imageStackView.addArrangedSubview)
        contentView.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.width.equalTo(76)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DailyCell {
    struct Item {
        var titleName: String
        var amountOfCalories: String
        var timeForPrep: String
        let taskImage: UIImage
        let backgroundColor: UIColor
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.titleName
        caloriesLabel.text = item.amountOfCalories
        dailyTime.text = item.timeForPrep
        taskImage.image = item.taskImage
        contentView.backgroundColor = item.backgroundColor
    }
}
