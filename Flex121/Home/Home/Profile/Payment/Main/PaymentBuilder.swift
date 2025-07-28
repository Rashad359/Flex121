//
//  PaymentBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/21/25.
//

import UIKit

class PaymentBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = PaymentViewModel(coordinator: coordinator)
        let paymentVC = PaymentVC(viewModel: viewModel)
        return paymentVC
    }
}
