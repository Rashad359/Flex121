//
//  ProfileViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didGetName(_ data: [String: Any])
    func error(_ error: Error)
}

class ProfileViewModel {
    
    private let coordinator: HomeCoordinator
    
    private let firebase = DependencyContainer.shared.firebaseManger
    
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
        guard let uid = firebase.uid else { return }

        firebase.fetchData(path: "users/\(uid)") { result in
            switch result {
            case .success(let data):
                
                self.delegate?.didGetName(data)
                
            case .failure(let error):
                
                self.delegate?.error(error)

            }
        }
    }
}
