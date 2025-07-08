//
//  LoginViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
//    func render(_ state: )
    func didLogin()
    func error(_ error: Error)
}

class LoginViewModel {
    
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    private let firebase: DBSession = DependencyContainer.shared.firebaseManger
    private weak var delegate: LoginViewModelDelegate? = nil
    
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
}
