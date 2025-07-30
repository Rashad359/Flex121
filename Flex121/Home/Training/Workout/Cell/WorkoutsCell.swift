//
//  WorkoutsCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/24/25.
//

import UIKit

class WorkoutsCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .underline
        return view
    }()
    
    private let workoutImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cardio"
        label.textColor = .openGray
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "7 Exercises > 10 min"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .closeGray
        return label
    }()
    
    private lazy var checkBox: CircularCheckbox = {
        let box = CircularCheckbox()
        box.layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        box.addGestureRecognizer(tapGesture)
        return box
    }()
    
    private let mainStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let leftStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 12
        return stackView
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    @objc
    private func didTapCheck() {
        checkBox.toggle()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(mainStackView)
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        [leftStackView, checkBox].forEach(mainStackView.addArrangedSubview)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        [workoutImage, textStackView].forEach(leftStackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension WorkoutsCell {
    struct Item {
        let title: String
        let subtitle: String
        let workoutImage: UIImage
    }
    
    func configure(_ item: Item) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        workoutImage.image = item.workoutImage
    }
}
