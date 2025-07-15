//
//  HomeCoordinator.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/15/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeController(coordinator: self)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func navigateToSettings() {
        let settingsVC = SettingsVC()
        self.navigationController.pushViewController(settingsVC, animated: true)
    }
    
    func openProfile() {
        let profileVC = ProfileBuilder(coordinator: self).build()
        navigationController.pushViewController(profileVC, animated: true)
    }
}
