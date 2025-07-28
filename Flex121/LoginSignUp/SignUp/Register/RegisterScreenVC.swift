//
//  RegisterScreenVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import FirebaseAuth

class RegisterScreenVC: BaseViewController {
    
    private let viewModel: RegisterScreenViewModel
    
    init(viewModel: RegisterScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .signupBackground
        imageView.alpha = 1.0
        return imageView
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.text = "WELCOME TO FLEX 121"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let subtitleText: UILabel = {
        let label = UILabel()
        label.text = "Enter your information or continue with another account"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private let emailTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Email"
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.backgroundColor = .background
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let nameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Name"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.title = "Password"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        return textField
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setImage(.apple, for: .normal)
        button.backgroundColor = .dark3
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(.google, for: .normal)
        button.backgroundColor = .dark3
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        return button
    }()
    
    private let bottomButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var proceedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 124).isActive = true
        button.backgroundColor = .main
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    @objc
    private func didTapSignIn() {
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text else { return }
        viewModel.signUp(with: emailText, password: passwordText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc
    private func didTapAppleButton() {
        viewModel.goToWebsite(url: "https://www.apple.com")
    }
    
    @objc
    private func didTapGoogleButton() {
        viewModel.goToWebsite(url: "https://www.google.com")
    }
    
    private func textFieldSetup() {
        let emailUnderline = CALayer()
        emailUnderline.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1)
        emailUnderline.backgroundColor = UIColor.underline.cgColor
        emailTextField.layer.addSublayer(emailUnderline)
        
        let nameUnderline = CALayer()
        nameUnderline.frame = CGRect(x: 0, y: nameTextField.frame.height - 1, width: nameTextField.frame.width, height: 1)
        nameUnderline.backgroundColor = UIColor.underline.cgColor
        nameTextField.layer.addSublayer(nameUnderline)
        
        let passwordUnderline = CALayer()
        passwordUnderline.frame = CGRect(x: 0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1)
        passwordUnderline.backgroundColor = UIColor.underline.cgColor
        passwordTextField.layer.addSublayer(passwordUnderline)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [emailTextField, nameTextField, passwordTextField].forEach( {$0.layoutIfNeeded()} )
        
        textFieldSetup()
    }
    
    private func setupUI() {
        
        [backgroundImage, textFieldStackView, textStackView, bottomStackView].forEach(view.addSubview)
        
        [appleButton, googleButton].forEach(bottomButtonStackView.addArrangedSubview)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        [emailTextField, nameTextField, passwordTextField].forEach(textFieldStackView.addArrangedSubview)
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        [titleText, subtitleText].forEach(textStackView.addArrangedSubview)
        textStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImage.snp.bottom).inset(75)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(120)
        }
        
        [bottomButtonStackView, proceedButton].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        appleButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        googleButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        viewModel.subscribe(self)
    }
}

extension RegisterScreenVC: RegisterScreenProtocol {
    func didSignUp() {
        self.viewModel.goToPosition()
        guard let nameText = nameTextField.text else { return }
        viewModel.setName(name: nameText)
        
//        let docRef = db.document("users/\(uid)")
//        docRef.setData([
//            "name": nameText
//        ]) { error in
//            if let error {
//                print(error.localizedDescription)
//            }
//            
//            print("All good")
//        }
    }
    
    func error(_ error: any Error) {
        self.createAlert(title: "Something went wrong", message: error.localizedDescription)
    }
    
    
}
