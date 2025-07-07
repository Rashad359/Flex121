//
//  AgeBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class AgeBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func buid() -> UIViewController {
        let viewModel = AgeViewModel(coordinator: coordinator)
        let ageVC = AgeVC(viewModel: viewModel)
        return ageVC
    }
}
