//
//  HomeBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit


class HomeBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: coordinator)
        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
}
