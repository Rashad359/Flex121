//
//  RegisterBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit

class RegisterBuilder {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = RegisterScreenViewModel(coordinator: coordinator)
        let vc = RegisterScreenVC(viewModel: viewModel)
        return vc
    }
}
