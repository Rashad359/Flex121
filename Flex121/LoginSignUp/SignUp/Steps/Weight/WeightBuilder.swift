//
//  WeightBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class WeightBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = WeightViewModel(coorindator: coordinator)
        let weightVC = WeightVC(viewModel: viewModel)
        return weightVC
    }
}
