//
//  WeightViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class WeightViewModel {
    private let coorindator: AppCoordinator
    
    init(coorindator: AppCoordinator) {
        self.coorindator = coorindator
    }
    
    func goToHeight() {
        coorindator.navigateToHeight()
    }
}
