//
//  HeightViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class HeightViewModel {
    private let coordiantor: AppCoordinator
    
    private let database = DependencyContainer.shared.databaseManager
    
    init(coordiantor: AppCoordinator) {
        self.coordiantor = coordiantor
    }
    
    func goToGoal() {
        coordiantor.navigateToGoal()
    }
    
    func addHeight(height: Int) {
        guard let uid = database.uid else { return }
        
        database.putData(path: "users/\(uid)", data: ["height": height])
    }
}
