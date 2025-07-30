//
//  OnboardingBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/27/25.
//

import UIKit

class OnboardingBuilder {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = OnboardingViewModel(coordinator: coordinator)
        let vc = OnboardingVC(viewModel: viewModel)
        return vc
    }
}
