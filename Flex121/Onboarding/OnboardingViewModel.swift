//
//  OnboardingViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/29/25.
//

import UIKit

class OnboardingViewModel {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    let items: [OnboardingCell.Item] = [
        .init(
            image: .dumbells,
            title: "Meet your coach,start your journey WITH FLEX 121".uppercased(),
            isButtonHidden: true
        ),
        .init(
            image: .lifting,
            title: "Create a workout plan to stay fit".uppercased(),
            isButtonHidden: true
        ),
        .init(
            image: .running,
            title: "No more excuses, do it now".uppercased(),
            isButtonHidden: false
        ),
    ]
    
    func goToGreeting() {
        coordinator.goToGreeting()
    }
}
