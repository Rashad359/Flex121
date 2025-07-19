//
//  ProfileViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

class ProfileViewModel {
    private let coordinator: HomeCoordinator
    
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
}
