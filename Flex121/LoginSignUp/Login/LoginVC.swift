//
//  LoginVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginVC: BaseViewController {
    
//    var targetConstraint: Constraint? = nil
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .loginBackground
        imageView.alpha = 1.0
        return imageView
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.text = "Welcome back, rookie"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
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
        button.setTitle("Log In", for: .normal)
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
        viewModel.logIn(with: emailText, password: passwordText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        moveKeyboard()
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(460)
        }
        
        view.addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-64)
            make.bottom.equalTo(backgroundImage.snp.bottom).offset(-68)
        }
        
        view.addSubview(bottomStackView)
        [googleButton, appleButton].forEach(bottomButtonStackView.addArrangedSubview)
        [bottomButtonStackView, proceedButton].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
        }
        
        view.addSubview(textFieldStackView)
        [emailTextField, passwordTextField].forEach(textFieldStackView.addArrangedSubview)
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(35)
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
    
    private func textFieldSetup() {
        let emailUnderline = CALayer()
        emailUnderline.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1)
        emailUnderline.backgroundColor = UIColor.underline.cgColor
        emailTextField.layer.addSublayer(emailUnderline)
        
        let passwordUnderline = CALayer()
        passwordUnderline.frame = CGRect(x: 0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1)
        passwordUnderline.backgroundColor = UIColor.underline.cgColor
        passwordTextField.layer.addSublayer(passwordUnderline)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [emailTextField, passwordTextField].forEach( {$0.layoutIfNeeded()} )
        
        textFieldSetup()
    }
    
    @objc
    private func didTapAppleButton() {
        viewModel.goToWebsite(url: "https://www.apple.com")
    }
    
    @objc
    private func didTapGoogleButton() {
        viewModel.goToWebsite(url: "https://www.google.com")
    }
}

extension LoginVC: LoginViewModelDelegate {
    func didLogin() {
        //Go to other screen
        print("Success")
        viewModel.goToHome()
    }
    
    func error(_ error: any Error) {
        self.createAlert(title: "Something went wrong", message: error.localizedDescription)
    }
    
    
}
