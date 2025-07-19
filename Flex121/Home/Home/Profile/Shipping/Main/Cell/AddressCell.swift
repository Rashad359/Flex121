//
//  ShippingCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class AddressCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let customerName: BaseLabel = {
        let label = BaseLabel()
        label.text = "Customer name"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let editIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .edit
        return imageView
    }()
    
    private let topStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .seperator
        return view
    }()
    
    private let descriptionLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "25 rue Robert Latouche, Nice, 06200, Côte D’azur, France"
        label.textColor = .subtitle
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var checkBox: CircularCheckbox = {
        let box = CircularCheckbox()
        box.layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        box.addGestureRecognizer(tapGesture)
        return box
    }()
    
    private let boxLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Use as the shipping address"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let bottomStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    @objc
    private func didTapCheck() {
        checkBox.toggle()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(backView)
        contentView.addSubview(bottomStackView)
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(bottomStackView.snp.top).offset(-16)
        }
        [topStackView, seperatorView, descriptionLabel].forEach(backView.addSubview)
        [customerName, editIcon].forEach(topStackView.addArrangedSubview)
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(seperatorView.snp.top).offset(-12)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
//            make.top.equalTo(topStackView.snp.bottom).offset(12)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        [checkBox, boxLabel].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        checkBox.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
