//
//  GreetingViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class GreetingViewModel {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToLogin() {
        coordinator.goToLogin()
    }
    
    func goToSignup() {
        coordinator.goToSignup()
    }
}
