//
//  AgeViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class AgeViewModel {
    private let coordinator: AppCoordinator
    
    private let database = DependencyContainer.shared.databaseManager
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToWeight() {
        coordinator.navigateToWeight()
    }
    
    func addAge(age: Int) {
        guard let uid = database.uid else { return }
        
        database.putData(path: "users/\(uid)", data: ["age": age])
    }
}
