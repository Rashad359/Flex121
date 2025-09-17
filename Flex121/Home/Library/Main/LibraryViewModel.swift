//
//  LibraryViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 8/21/25.
//

import UIKit

class LibraryViewModel {
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToNutritionLib() {
        coordinator.navigateToNutritionLib()
    }
}
