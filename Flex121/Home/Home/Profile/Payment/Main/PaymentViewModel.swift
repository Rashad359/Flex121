//
//  PaymentViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/21/25.
//

import UIKit

class PaymentViewModel {
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToAddPayment() {
        coordinator.navigateToAddPayment()
    }
}
