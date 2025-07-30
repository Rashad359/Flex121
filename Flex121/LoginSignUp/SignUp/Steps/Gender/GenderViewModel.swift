//
//  GenderViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class GenderViewModel {
    private let coordinator: AppCoordinator
    
    private let database = DependencyContainer.shared.databaseManager
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToAge() {
        coordinator.navigateToAge()
    }
    
    func addGender(gender: String) {
        guard let uid = database.uid else { return }
        
        database.putData(path: "users/\(uid)", data: ["gender": gender])
    }
}
