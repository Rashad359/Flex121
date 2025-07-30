//
//  TopCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/14/25.
//

import UIKit

class TopCell: UITableViewCell {
    
    private let genderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let genderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .woman
        return imageView
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .genericUser
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Sam Height"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 20)
        label.textColor = .main
        return label
    }()
    
    private let additionalInfo: UILabel = {
        let label = UILabel()
        label.text = "Member since 24th Feb 2024"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = .zero
        label.textColor = .lightGray
        return label
    }()
    
    private let mainStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.alignment = .center
        stackView.spacing = 40
        return stackView
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(mainStackView)
        profileImage.addSubview(genderView)
        genderView.addSubview(genderImage)
        [profileImage, textStackView].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(28)
            make.bottom.equalToSuperview()
        }
        [profileName, additionalInfo].forEach(textStackView.addArrangedSubview)
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(140)
        }
        
        genderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(profileImage.snp.bottom)
            make.size.equalTo(40)
        }
        
        genderImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TopCell {
    struct Item {
        var userName: String
    }
    
    func configure(_ item: Item) {
        profileName.text = item.userName
    }
}
