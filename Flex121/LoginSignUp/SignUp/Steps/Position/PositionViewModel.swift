//
//  PositionViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class PositionViewModel {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToGender() {
        coordinator.navigateToGender()
    }
}
