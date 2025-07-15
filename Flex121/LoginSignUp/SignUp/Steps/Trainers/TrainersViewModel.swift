//
//  TrainersViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit

class TrainersViewModel {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToHome() {
        coordinator.restartHomeFlow()
    }
}
