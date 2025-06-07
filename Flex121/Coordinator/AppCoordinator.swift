//
//  AppCoordinator.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/27/25.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = OnboardingBuilder(coordinator: self).build()
        navigationController.setViewControllers([vc], animated: true)
    }
}
