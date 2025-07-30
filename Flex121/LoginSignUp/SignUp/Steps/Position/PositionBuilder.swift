//
//  PositionBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class PositionBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = PositionViewModel(coordinator: coordinator)
        let positionVC = PositionVC(viewModel: viewModel)
        return positionVC
    }
}
