//
//  AddPaymentBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/22/25.
//

import UIKit

class AddPaymentBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = AddPaymentViewModel(coordinator: coordinator)
        let vc = AddPaymentVC(viewModel: viewModel)
        return vc
    }
}
