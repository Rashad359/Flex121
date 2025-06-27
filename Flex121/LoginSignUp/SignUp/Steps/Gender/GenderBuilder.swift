//
//  GenderBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class GenderBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = GenderViewModel(coordinator: coordinator)
        let genderVC = GenderVC(viewModel: viewModel)
        return genderVC
    }
}
