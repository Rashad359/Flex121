//
//  TrainersCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit
import SnapKit

class TrainersCell: UICollectionViewCell {
    
    private let trainerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .dumbells
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trainerName: UILabel = {
        let label = UILabel()
        label.text = "Richard Will"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let trainerCategory: UILabel = {
        let label = UILabel()
        label.text = "High intensity Training"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.text = "5 years experience"
        label.textColor = .brightGreen
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .brightGreen
        return view
    }()
    
    private let ratingScore: UILabel = {
        let label = UILabel()
        label.text = "4.8"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private let sendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .send
        return imageView
    }()
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 13
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let topTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .underline
        contentView.addSubview(cellStackView)
        ratingView.addSubview(ratingScore)
        [leftStackView, sendImage].forEach(cellStackView.addArrangedSubview)
        cellStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        [trainerImage, textStackView].forEach(leftStackView.addArrangedSubview)
        [titleStackView, trainerCategory].forEach(topTextStackView.addArrangedSubview)
//        [titleStackView, trainerCategory, experienceLabel].forEach(textStackView.addArrangedSubview)
        [topTextStackView, experienceLabel].forEach(textStackView.addArrangedSubview)
        [trainerName, ratingView].forEach(titleStackView.addArrangedSubview)
        
        trainerImage.snp.makeConstraints { make in
            make.size.equalTo(64)
        }
        
        ratingView.snp.makeConstraints { make in
            make.width.equalTo(33)
            make.height.equalTo(16)
        }
        
        ratingScore.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TrainersCell {
    struct Item {
        let rating: String
        let category: String
        let experience: String
        let trainerImage: UIImage
        let trainerName: String
    }
    
    func configure(_ item: Item) {
        ratingScore.text = item.rating
        trainerCategory.text = item.category
        experienceLabel.text = item.experience
        trainerImage.image = item.trainerImage
        trainerName.text = item.trainerName
    }
}
