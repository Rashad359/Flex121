//
//  ProfileBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

class ProfileBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = ProfileViewModel(coordinator: coordinator)
        let vc = ProfileVC(viewModel: viewModel)
        return vc
    }
}
