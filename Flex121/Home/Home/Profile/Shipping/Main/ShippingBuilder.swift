//
//  ShippingBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class ShippingBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = ShippingViewModel(coordinator: coordinator)
        let shippingVC = ShippingVC(viewModel: viewModel)
        return shippingVC
    }
}
