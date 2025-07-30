//
//  HeightBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class HeightBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = HeightViewModel(coordiantor: coordinator)
        let heightVC = HeightVC(viewModel: viewModel)
        return heightVC
    }
}
