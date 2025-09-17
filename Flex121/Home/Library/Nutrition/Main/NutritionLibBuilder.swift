//
//  NutritionLibBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 8/21/25.
//

import UIKit

class NutritionLibBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func buid() -> UIViewController {
        let viewModel = NutritionLibViewModel(coordinator: coordinator)
        let vc = NutritionLibVC(viewModel: viewModel)
        return vc
    }
}
