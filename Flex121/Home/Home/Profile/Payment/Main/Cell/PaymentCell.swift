//
//  PaymentCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/21/25.
//

import UIKit

class PaymentCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .softPink
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let cardNumber: UILabel = {
        let label = UILabel()
        label.text = "1111 1111 1111 1111"
        label.textColor = .black
        return label
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textColor = .black
        return label
    }()
    
    private let expirationDate: UILabel = {
        let label = UILabel()
        label.text = "01/01"
        label.textColor = .black
        return label
    }()
    
    private let paymentCompanyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .mastercard
        return imageView
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
        label.text = "Use as the payment method"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let bottomStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let credentialsStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 1
        return stackView
    }()
    
    private let cardBottomStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
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
        contentView.addSubview(bottomStackView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(214)
            make.bottom.equalTo(bottomStackView.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        [cardNumber, bottomView].forEach(backView.addSubview)
        bottomView.addSubview(cardBottomStackView)
        bottomView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        
        cardNumber.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(21)
        }
        
        [userName, expirationDate].forEach(credentialsStackView.addArrangedSubview)
        [credentialsStackView, paymentCompanyImage].forEach(cardBottomStackView.addArrangedSubview)
        cardBottomStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-21)
            make.horizontalEdges.equalToSuperview().inset(21)
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
