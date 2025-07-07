//
//  LevelBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class LevelBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = LevelViewModel(coordinator: coordinator)
        let levelVC = LevelVC(viewModel: viewModel)
        return levelVC
    }
}
