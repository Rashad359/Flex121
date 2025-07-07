//
//  HeightViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//

import UIKit

class HeightViewModel {
    private let coordiantor: AppCoordinator
    
    init(coordiantor: AppCoordinator) {
        self.coordiantor = coordiantor
    }
    
    func goToGoal() {
        coordiantor.navigateToGoal()
    }
}
