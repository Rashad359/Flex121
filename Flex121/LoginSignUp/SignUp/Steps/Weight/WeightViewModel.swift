//
//  WeightViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class WeightViewModel {
    private let coorindator: AppCoordinator
    
    private let database = DependencyContainer.shared.databaseManager
    
    init(coorindator: AppCoordinator) {
        self.coorindator = coorindator
    }
    
    func goToHeight() {
        coorindator.navigateToHeight()
    }
    
    func addWeight(weight: Int) {
        guard let uid = database.uid else { return }
        
        database.putData(path: "users/\(uid)", data: ["weight": weight])
    }
}
