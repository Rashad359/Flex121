//
//  questCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/14/25.
//

import UIKit

class QuestCell: UITableViewCell {
    
    private let stepsDone: CGFloat = 1092
    private let totalSteps: CGFloat = 10000
    private lazy var currentProgress = stepsDone / totalSteps
    
    private let runnerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .runnerIcon
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "You're off to a great start!"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 20)
        label.numberOfLines = .zero
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Steps left to defeat ⚔️"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let stepsLabel: UILabel = {
        let label = UILabel()
        label.text = "8,908"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 24)
        label.textColor = .brightGreen
        return label
    }()
    
    private let topStackView: UIStackView = {
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
        stackView.spacing = 12
        return stackView
    }()
    
    private let subtitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let progressTrackerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    private let progressFillView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen //change color later
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    private let setpsDoneLabel: UILabel = {
        let label = UILabel()
        label.text = "1,092 steps done"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let stepsGoalLabel: UILabel = {
        let label = UILabel()
        label.text = "Goal 10,000"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
//    private let chestIcon: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = .chest //change it to chest later
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .white
//        imageView.layer.cornerRadius = 18
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .background
        
        contentView.addSubview(topStackView)
        contentView.addSubview(progressTrackerView)
        contentView.addSubview(bottomStackView)
        progressTrackerView.addSubview(progressFillView)
//        contentView.addSubview(chestIcon)
        contentView.layer.cornerRadius = 24
        contentView.backgroundColor = .lightMain
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        [runnerImage, textStackView, subtitleStackView].forEach(topStackView.addArrangedSubview)
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        [titleLabel, subtitleStackView].forEach(textStackView.addArrangedSubview)
        [subtitleLabel, stepsLabel].forEach(subtitleStackView.addArrangedSubview)
        [setpsDoneLabel, stepsGoalLabel].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(progressTrackerView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        runnerImage.snp.makeConstraints { make in
            make.size.equalTo(120)
        }
        
        progressTrackerView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview().inset(16)
//            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(12)
        }
        
        progressFillView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(progressTrackerView.snp.width).multipliedBy(currentProgress)
        }
        
//        chestIcon.snp.makeConstraints { make in
//            make.centerY.equalTo(progressTrackerView)
//            make.size.equalTo(36)
//            make.trailing.equalTo(progressTrackerView.snp.trailing).offset(18)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension QuestCell {
    struct Item {
        let stepsDone: String
    }
    
    func configure(_ item: Item) {
        stepsLabel.text = item.stepsDone
    }
}
