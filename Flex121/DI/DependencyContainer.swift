//
//  DependencyContainer.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/8/25.
//

import UIKit

class DependencyContainer {
    static let shared = DependencyContainer()
    
    lazy var firebaseManger: DBSession = {
        return FirebaseAdapter()
    }()
    
    lazy var userDefaults: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
}
