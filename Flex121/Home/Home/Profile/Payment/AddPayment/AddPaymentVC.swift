//
//  AddPaymentVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/22/25.
//

import UIKit

final class AddPaymentVC: BaseViewController {
    
    private let viewModel: AddPaymentViewModel
    
    init(viewModel: AddPaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .card
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Full name"
        textField.layer.cornerRadius = 8
        textField.textColor = .white
        textField.selectedTitleColor = .white
        textField.titleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Full name",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let cardNumTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Card number"
        textField.layer.cornerRadius = 8
        textField.textColor = .white
        textField.selectedTitleColor = .white
        textField.titleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Card number",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let cvvTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "CVV"
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.selectedTitleColor = .white
        textField.titleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "CVV",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let expirationTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Expiration date"
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.selectedTitleColor = .white
        textField.titleColor = .white
        textField.backgroundColor = .underline
        textField.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Expiration Date",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let addButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.setTitle("Add new card", for: .normal)
        button.layer.cornerRadius = 24
        button.backgroundColor = .main
        return button
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private let botTextStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLeftNavButton()
    }
    
    private func setupUI() {
        title = "Add payment method"
        [cardImage, textStackView, addButton].forEach(view.addSubview)
        [nameTextField, cardNumTextField, botTextStackView].forEach(textStackView.addArrangedSubview)
        [cvvTextField, expirationTextField].forEach(botTextStackView.addArrangedSubview)
        
        cardImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(textStackView.snp.top).offset(-32)
            make.height.equalTo(214)
        }
        
        textStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
//            make.bottom.equalTo(addButton.snp.top).offset(-35)
        }
        
        addButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(66)
        }
        
        botTextStackView.snp.makeConstraints { make in
            make.height.equalTo(66)
        }
    }
}
