//
//  RegisterScreenViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/8/25.
//

import UIKit

class RegisterScreenViewModel {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToWebsite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func goToPosition() {
        coordinator.navigateToPosition()
    }
}
