//
//  ShippingViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class ShippingViewModel {
    
    private let userDefaults = DependencyContainer.shared.userDefaults
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToAdd() {
        coordinator.navigateToAddShipping()
    }
    
    func saveList(_ list: [AddressCell.Item]) {
        userDefaults.saveState(list: list)
    }
    
    func getList() -> [AddressCell.Item] {
        return userDefaults.getState()
    }
}
