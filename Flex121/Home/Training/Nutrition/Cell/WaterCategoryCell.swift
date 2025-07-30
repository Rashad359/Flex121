//
//  WaterCategoryCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/23/25.
//

import UIKit

class WaterCategoryCell: UITableViewCell {
    
    private var selectedIndex: Int = 0

    private let amount: [Double] = stride(from: 0.1, through: 5.0, by: 0.1).map { Double(round(10 * $0) / 10) }
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .underline
        return view
    }()
    
    private let leftView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .openCyan
        return view
    }()
    
    private let waterLabel: UILabel = {
        let label = UILabel()
        label.text = "Water"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        label.textColor = .openCyan
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let waterAmount: UILabel = {
        let label = UILabel()
        label.text = "0.9L(75%)"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended until now 1.4L"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let waterDropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .waterDrops
        return imageView
    }()
    
    private lazy var amountPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var plusAmount: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .brightGreen
        button.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusAmount: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.tintColor = .brightGreen
        button.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        return button
    }()
    
    private let waterStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 3
        return stackView
    }()
    
    private let leftStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 2
        return stackView
    }()
    
    private let rightStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    @objc
    private func didTapPlus() {
        if selectedIndex < amount.count - 1 {
            selectedIndex += 1
            amountPicker.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    @objc
    private func didTapMinus() {
        if selectedIndex > 0 {
            selectedIndex -= 1
            amountPicker.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(backView)
        selectionStyle = .none
        
        [leftView, leftStackView, rightStackView].forEach(backView.addSubview)
        
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(76)
        }
        
        [minusAmount, amountPicker, plusAmount].forEach(rightStackView.addArrangedSubview)
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15.5)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        [textStackView, waterDropImage].forEach(leftStackView.addArrangedSubview)
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalTo(leftView.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        [waterStackView, subtitleLabel].forEach(textStackView.addArrangedSubview)
        
        [waterLabel, waterAmount].forEach(waterStackView.addArrangedSubview)
        
        leftView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(16)
        }
        
        amountPicker.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        waterDropImage.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        
        minusAmount.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        plusAmount.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension WaterCategoryCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        amount.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 62
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "\(amount[row])L"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }
}
