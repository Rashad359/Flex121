//
//  TrainersBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit

class TrainersBuilder {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = TrainersViewModel(coordinator: coordinator)
        let trainerVC = TrainersVC(viewModel: viewModel)
        return trainerVC
    }
}
