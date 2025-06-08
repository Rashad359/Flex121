//
//  LoginViewController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit

final class GreetingViewController: BaseViewController {
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = .pulling
        return image
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "do you have an account?".uppercased()
        label.numberOfLines = .zero
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Archivo Black", size: 24)
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let logInButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.backgroundColor = .background
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.main.cgColor
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: 17)
        button.setTitleColor(.main, for: .normal)
        return button
    }()
    
    private let signUpButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.backgroundColor = .main
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: 17)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupButtons()
    }
    
    private func setupButtons() {
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc private func didTapSignUp() {
        let viewModel = RegisterScreenViewModel()
        let vc = RegisterScreenVC(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        [mainImage, mainLabel, buttonStackView].forEach { component in
            view.addSubview(component)
        }
        
        [logInButton, signUpButton].forEach { component in
            buttonStackView.addArrangedSubview(component)
        }
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 497),
            
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 25),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
