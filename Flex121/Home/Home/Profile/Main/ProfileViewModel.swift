//
//  ProfileViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didGetName(_ data: [String: Any])
    func didGetBio(_ data: [String: Any])
    func error(_ error: Error)
}

class ProfileViewModel {
    
    private let userDefaults = DependencyContainer.shared.userDefaults
    
    private let coordinator: HomeCoordinator
    
    private let database = DependencyContainer.shared.databaseManager
    
    private weak var delegate: ProfileViewDelegate? = nil
    
    func subscribe(_ delegate: ProfileViewDelegate) {
        self.delegate = delegate
    }
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToOrders() {
        coordinator.navigateToOrders()
    }
    
    func goToSettings() {
        coordinator.navigateToSettings()
    }
    
    func goToShipping() {
        coordinator.navigateToShipping()
    }
    
    func goToPayment() {
        coordinator.navigateToPayment()
    }
    
    func navToSettings() {
        coordinator.navigateToSettings()
    }
    
    func getUserName() {
        guard let uid = database.uid else { return }

        database.fetchData(path: "users/\(uid)") { result in
            switch result {
            case .success(let data):
                
                self.delegate?.didGetName(data)
                
            case .failure(let error):
                
                self.delegate?.error(error)

            }
        }
    }
    
    func logOut() {
        userDefaults.logout()
        coordinator.logout()
    }
    
    func fetchBiometrics() {
        guard let uid = database.uid else { return }
        
        database.fetchData(path: "users/\(uid)") { result in
            switch result {
            case .success(let data):
                
                self.delegate?.didGetBio(data)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
}
