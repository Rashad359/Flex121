//
//  SettingsViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/29/25.
//

import UIKit

class SettingsViewModel {
    private let database = DependencyContainer.shared.databaseManager
    
    func changeName(to username: String) {
        guard let uid = database.uid else { return }
        
        database.putData(path: "users/\(uid)", data: ["name": username])
    }
    
//    func changeEmail(to newEmail: String) {
//        database.changeEmail(to: newEmail)
//    }
    
    func changeEmail(with password: String, to newEmail: String) {
        database.reauthenticateAndChangeEmail(password: password, newEmail: newEmail)
    }
}
