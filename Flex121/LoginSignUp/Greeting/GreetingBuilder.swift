//
//  GreetingBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class GreetingBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = GreetingViewModel(coordinator: coordinator)
        let greetingVC = GreetingViewController(viewModel: viewModel)
        return greetingVC
    }
}
