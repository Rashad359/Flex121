//
//  FoodCatalogue.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 9/6/25.
//

import UIKit

class FoodCatalogue: UICollectionViewCell {
    
    private let mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .apple
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Generic Salad"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtitle for salad"
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        
        return label
    }()
    
    private let mainStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to diet", for: .normal)
        button.backgroundColor = .main
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 10)
        button.tintColor = .white
        
        return button
    }()
    
    private let likeView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private let likeImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .underline
        layer.cornerRadius = 16
        
        [likeView, mainStackView, addButton].forEach(contentView.addSubview)
        
        [mealImage, titleLabel, subtitleLabel].forEach(mainStackView.addArrangedSubview)
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(21)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalTo(addButton.snp.top).offset(-12)
        }
        
        likeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        mealImage.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.width.equalTo(112)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FoodCatalogue {
    struct Item {
        let foodImage: UIImage
        let title: String
        let subtitle: String
    }
    
    func configure(_ item: Item) {
        mealImage.image = item.foodImage
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
