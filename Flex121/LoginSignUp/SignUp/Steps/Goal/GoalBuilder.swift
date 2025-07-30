//
//  GoalBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class GoalBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = GoalViewModel(coordinator: coordinator)
        let goalVC = GoalVC(viewModel: viewModel)
        return goalVC
    }
}
