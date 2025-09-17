//
//  AllFoodCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/25/25.
//

import UIKit

class AllFoodCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .underline
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "calories"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let proteinLabel: UILabel = {
        let label = UILabel()
        label.text = "protein"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .salad
        return imageView
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let subtitleStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 2
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(backView)
        [textStackView, foodImage].forEach(backView.addSubview)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [titleLabel, subtitleStackView].forEach(textStackView.addArrangedSubview)
        
        textStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        [caloriesLabel, proteinLabel].forEach(subtitleStackView.addArrangedSubview)
        
        foodImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension AllFoodCell {
    struct Item {
        let title: String
        let calories: String
        let protein: String
        let foodImage: UIImage
//        let mainColor: UIColor
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.title
        caloriesLabel.text = item.calories
        proteinLabel.text = item.protein
        foodImage.image = item.foodImage
    }
}
