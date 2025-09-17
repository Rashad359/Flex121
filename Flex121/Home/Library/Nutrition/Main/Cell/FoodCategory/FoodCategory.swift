//
//  FoodCategory.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 8/26/25.
//

import UIKit

class FoodCategory: UICollectionViewCell {
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.text = "Product"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 15)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .underline
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentView.addSubview(productLabel)
        
        productLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(6)
        }
    }
}

extension FoodCategory {
    struct Item {
        let name: String
    }
    
    func configure(_ item: Item) {
        productLabel.text = item.name
    }
}
