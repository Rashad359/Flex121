//
//  SignupPageBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/27/25.
//

import UIKit

class SignupPageBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build(with vc: SignupPage) -> UIViewController {
        let signupPage = SignupPageController(coordinator: coordinator, startingPage: vc)
        return signupPage
    }
}
