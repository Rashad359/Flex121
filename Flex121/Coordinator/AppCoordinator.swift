//
//  AppCoordinator.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/27/25.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

class AppCoordinator: Coordinator {
    private var homeCoordinator: HomeCoordinator?
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
    
    func navigateToAge() {
        let ageVC = AgeBuilder(coordinator: self).buid()
        navigationController.pushViewController(ageVC, animated: true)
    }
    
    func navigateToWeight() {
        let weightVC = WeightBuilder(coordinator: self).build()
        navigationController.pushViewController(weightVC, animated: true)
    }
    
    func navigateToHeight() {
        let heightVC = HeightBuilder(coordinator: self).build()
        navigationController.pushViewController(heightVC, animated: true)
    }
    
    func navigateToGoal() {
        let goalVC = GoalBuilder(coordinator: self).build()
        navigationController.pushViewController(goalVC, animated: true)
    }
    
    func navigateToLevel() {
        let levelVC = LevelBuilder(coordinator: self).build()
        navigationController.pushViewController(levelVC, animated: true)
    }
    
    func navigateToTrainers() {
        let trainerVC = TrainersBuilder(coordinator: self).build()
        navigationController.pushViewController(trainerVC, animated: true)
    }
    
    func startHomeFlow() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        self.homeCoordinator = homeCoordinator
        homeCoordinator.start()
    }
    
    func restartHomeFlow() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        self.homeCoordinator = homeCoordinator
        homeCoordinator.start()
    }
}
