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
    
    func goToGreeting() {
        let greetingVC = GreetingBuilder(coordinator: self).build()
        navigationController.setViewControllers([greetingVC], animated: true)
    }
    
    func goToSignup() {
        let signupVC = SignupPageBuilder(coordinator: self).build(with: .register)
        navigationController.setViewControllers([signupVC], animated: true)
    }
    
    func goToLogin() {
        let loginVC = SignupPageBuilder(coordinator: self).build(with: .login)
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    func navigateToPosition() {
        let positionVC = PositionBuilder(coordinator: self).build()
        navigationController.pushViewController(positionVC, animated: true)
    }
    
    func navigateToGender() {
        let genderVC = GenderBuilder(coordinator: self).build()
        navigationController.pushViewController(genderVC, animated: true)
    }
}
