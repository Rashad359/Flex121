//
//  SignupPageController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit
import SnapKit

enum SignupPage {
    case register
    case login
}

class SignupPageController: UIPageViewController {
    
    private let coordinator: AppCoordinator
    
    private let startingPage: SignupPage
    
    init(coordinator: AppCoordinator, startingPage: SignupPage) {
        self.coordinator = coordinator
        self.startingPage = startingPage
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pages: [UIViewController] = [
        RegisterBuilder(coordinator: coordinator).build(),
        LoginBuilder(coordinator: coordinator).build()
    ]
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.layer.cornerRadius = 1
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.opacity = 1.0
        button.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        return stackView
    }()
    
    @objc
    private func didTapSignup() {
        setViewControllers([pages[0]], direction: .forward, animated: true)
        underLineView.snp.remakeConstraints { make in
            make.horizontalEdges.equalTo(signUpButton.snp.horizontalEdges)
            make.top.equalTo(signUpButton.snp.bottom).offset(4)
            make.height.equalTo(3)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func didTapLogin() {
        setViewControllers([pages[1]], direction: .reverse, animated: true)
        underLineView.snp.remakeConstraints { make in
            make.horizontalEdges.equalTo(logInButton.snp.horizontalEdges)
            make.top.equalTo(logInButton.snp.bottom).offset(4)
            make.height.equalTo(3)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        moveKeyboard()
    }
    
    func moveKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            view.frame.origin.y = -keyboardHeight
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.isScrollEnabled = false
            }
        }
        view.addSubview(buttonStackView)
        [logInButton, signUpButton].forEach(buttonStackView.addArrangedSubview)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.leading.equalToSuperview().offset(24)
        }
        
        view.addSubview(underLineView)
        underLineView.snp.makeConstraints { make in
            make.leading.equalTo(signUpButton.snp.leading)
            make.trailing.equalTo(signUpButton.snp.trailing)
            make.top.equalTo(signUpButton.snp.bottom).offset(4)
            make.height.equalTo(3)
        }
        
        switch startingPage {
        case .register:
            setViewControllers([pages[0]], direction: .forward, animated: true)
        case .login:
            setViewControllers([pages[1]], direction: .forward, animated: true)
            underLineView.snp.remakeConstraints { make in
                make.horizontalEdges.equalTo(logInButton.snp.horizontalEdges)
                make.top.equalTo(logInButton.snp.bottom).offset(4)
                make.height.equalTo(3)
            }
        }
    }
}

//extension SignupPageController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
//        return pages[index - 1]
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
//        return pages[index + 1]
//    }
//}
