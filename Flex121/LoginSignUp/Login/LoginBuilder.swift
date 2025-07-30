//
//  LoginBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit

class LoginBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = LoginViewModel(coordinator: coordinator)
        let vc = LoginVC(viewModel: viewModel)
        return vc
    }
}
