//
//  OrdersCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

class OrdersCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let orderNumber: UILabel = {
        let label = UILabel()
        label.text = "Order number"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .white
        return label
    }()
    
    private let orderDate: UILabel = {
        let label = UILabel()
        label.text = "18/01/1020"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let orderInfoStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .seperator
        return view
    }()
    
    private let quantityLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Quantity:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let quantityNumber: BaseLabel = {
        let label = BaseLabel()
        label.text = "03"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let quantityStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 2
        return stackView
    }()
    
    private let totalAmountLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Total amount:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let totalAmountNumber: BaseLabel = {
        let label = BaseLabel()
        label.text = "$150"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let amountStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 2
        return stackView
    }()
    
    private let midStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detail", for: .normal)
        button.backgroundColor = .main
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    private let confirmationLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Delivered"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .green
        return label
    }()
    
    private let bottomStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        [orderInfoStackView, seperatorView, midStackView, bottomStackView].forEach(backView.addSubview)
        [orderNumber, orderDate].forEach(orderInfoStackView.addArrangedSubview)
        orderInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(orderInfoStackView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(2)
        }
        [quantityStackView, amountStackView].forEach(midStackView.addArrangedSubview)
        midStackView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        [quantityLabel, quantityNumber].forEach(quantityStackView.addArrangedSubview)
        [totalAmountLabel, totalAmountNumber].forEach(amountStackView.addArrangedSubview)
        [detailButton, confirmationLabel].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(midStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        detailButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.greaterThanOrEqualTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension OrdersCell {
    struct Item {
        let orderNumber: String
        let orderDate: String
        let quantity: String
        let amount: String
    }
    
    func configure(_ item: Item) {
        orderNumber.text = "Order No\(item.orderNumber)"
        orderDate.text = item.orderDate
        quantityNumber.text = item.quantity
        totalAmountNumber.text = "$\(item.amount)"
    }
}
