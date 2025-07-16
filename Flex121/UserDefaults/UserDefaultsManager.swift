//
//  UserDefaultsManager.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/14/25.
//

import UIKit

class UserDefaultsManager {

    let userDefaults: UserDefaults
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    private var key = "Key"
    
    func login(with bool: Bool) {
        userDefaults.set(bool, forKey: key)
    }
    
    func isUserLoggedIn() -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    func logout() {
        userDefaults.removeObject(forKey: key)
    }
}
