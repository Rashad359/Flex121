//
//  RegisterScreenViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/8/25.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func didSignUp()
    func error(_ error: Error)
}

class RegisterScreenViewModel {
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    private let coordinator: AppCoordinator
    private let firebase: DBSession = DependencyContainer.shared.firebaseManger
    
    private weak var delegate: RegisterScreenProtocol? = nil
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func subscribe(_ delegate: RegisterScreenProtocol) {
        self.delegate = delegate
    }
    
    func goToWebsite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func goToPosition() {
        coordinator.navigateToPosition()
    }
    
    func signUp(with email: String, password: String) {
        firebase.signUp(with: email, password: password) { result in
            switch result {
            case .success(_):
                self.delegate?.didSignUp()
            case .failure(let error):
                self.delegate?.error(error)
            }
        }
    }
    
    func setName(name: String) {
        guard let uid = firebase.uid else { return }
        firebase.putData(path: "users/\(uid)", data: [
            "name": name
        ])
    }
}
