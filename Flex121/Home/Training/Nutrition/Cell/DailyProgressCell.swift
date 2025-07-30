//
//  ProgressCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/22/25.
//

import UIKit

class DailyProgressCell: UITableViewCell {
    
    private lazy var circularProgressView = CircularProgressBarView()
    
    private let kcalLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textColor = .main
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 36)
        return label
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Kcal available"
        label.textColor = .subLabel
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()
    
    private let burnImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .fire
        return imageView
    }()
    
    private let burnedCalories: UILabel = {
        let label = UILabel()
        label.text = "690"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 24)
        return label
    }()
    
    private let burnedPrompt: UILabel = {
        let label = UILabel()
        label.text = "burn"
        label.textColor = .subLabel
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let leftStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
    
    private let eatImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .restaurant
        return imageView
    }()
    
    private let eatenCalories: UILabel = {
        let label = UILabel()
        label.text = "536"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 24)
        return label
    }()
    
    private let eatenPrompt: UILabel = {
        let label = UILabel()
        label.text = "eaten"
        label.textColor = .subLabel
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let rightStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "2181"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 24)
        return label
    }()
    
    private let goalPrompt: UILabel = {
        let label = UILabel()
        label.text = "Kcal Goal"
        label.textColor = .subLabel
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let bottomStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 2
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
        [leftStackView, circularProgressView, rightStackView, bottomStackView].forEach(contentView.addSubview)
        circularProgressView.addSubview(textStackView)
        [kcalLabel, promptLabel].forEach(textStackView.addArrangedSubview)
        [burnImage, burnedCalories, burnedPrompt].forEach(leftStackView.addArrangedSubview)
        [eatImage, eatenCalories, eatenPrompt].forEach(rightStackView.addArrangedSubview)
        [goalLabel, goalPrompt].forEach(bottomStackView.addArrangedSubview)
        
//        contentView.snp.makeConstraints { make in
//            make.height.equalTo(503)
//        }
        
        textStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        circularProgressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(158)
        }
        
        leftStackView.snp.makeConstraints { make in
            make.centerY.equalTo(circularProgressView.snp.centerY)
            make.leading.equalToSuperview().offset(24)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.centerY.equalTo(circularProgressView.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(circularProgressView.snp.bottom).offset(41)
            make.bottom.equalToSuperview()
        }
        
        circularProgressView.setProgress(progress1: 0.2, progress2: 0.5, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
