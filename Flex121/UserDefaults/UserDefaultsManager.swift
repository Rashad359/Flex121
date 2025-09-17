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
    private var currentKey = "CurrentKey"
    
    func saveState(list: [AddressCell.Item]) {
        if let encodedData = try? JSONEncoder().encode(list) {
            userDefaults.setValue(encodedData, forKey: currentKey)
            userDefaults.synchronize()
        }
    }
    
    func getState() -> [AddressCell.Item] {
        if let item = userDefaults.object(forKey: currentKey) as? Data {
            if let decodedData = try? JSONDecoder().decode([AddressCell.Item].self, from: item) {
                return decodedData
            }
        }
        
        return []
    }
    
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
