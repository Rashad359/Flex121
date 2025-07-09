//
//  ProfileCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit
import SnapKit

class ProfileCell: UICollectionViewCell {
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .genericUser
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 17)
        return label
    }()
    
    private let messageToUser: UILabel = {
        let label = UILabel()
        label.text = "Good morning."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let messageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .message
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
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
        stackView.spacing = 12
        return stackView
    }()
    
    private let textStackView: UIStackView = {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(mainStackView)
        rightView.addSubview(messageLogo)
        [leftStackView, rightView].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        [profileImage, textStackView].forEach(leftStackView.addArrangedSubview)
        [profileName, messageToUser].forEach(textStackView.addArrangedSubview)
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        rightView.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        messageLogo.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


extension ProfileCell {
    struct Item {
        let profileImage: UIImage
        let username: String
        let dailyMessage: String
    }
    
    func configure(_ item: Item) {
        profileImage.image = item.profileImage
        profileName.text = item.username
        messageToUser.text = item.dailyMessage
    }
}
