//
//  OnboardingCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.dumbells
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "meet your coach, start your journey with flex 121".uppercased()
        label.numberOfLines = .zero
        label.textColor = .white
        label.font = UIFont(name: "Archivo Black", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let startButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.backgroundColor = .main
        button.widthAnchor.constraint(equalToConstant: 139).isActive = true
        button.setTitle("Start now", for: .normal)
        button.titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: 17)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupButton()
    }
    
    private func setupButton() {
        startButton.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    }
    
    var goToLogin: (() -> ())?
    
    @objc private func didTapStart() {
        goToLogin?()
    }
    
    private func setupUI() {
        [mainImage, mainLabel, startButton].forEach { component in
            contentView.addSubview(component)
        }
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 497),
            
            mainLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 25),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            startButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 46)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingCell {
    struct Item {
        let image: UIImage
        let title: String
        let isButtonHidden: Bool
    }
    
    func configure(_ item: Item) {
        mainImage.image = item.image
        mainLabel.text = item.title
        startButton.isHidden = item.isButtonHidden
    }
}
