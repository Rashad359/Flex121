//
//  LoginViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
    func didLogin()
    func error(_ error: Error)
}

class LoginViewModel {
    
    private let coordinator: AppCoordinator
    
    private let firebase = DependencyContainer.shared.databaseManager
    
    private weak var delegate: LoginViewModelDelegate? = nil
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func subscribe(_ delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func goToWebsite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func logIn(with email: String, password: String) {
        firebase.logIn(with: email, password: password) { result in
            switch result {
            case .success(_):
                self.delegate?.didLogin()
            case .failure(let error):
                self.delegate?.error(error)
            }
        }
    }
    
    func goToHome() {
        coordinator.startHomeFlow()
    }
}
