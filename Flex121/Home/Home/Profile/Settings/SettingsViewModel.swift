//
//  SettingsViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/29/25.
//

import UIKit

protocol SettingsDelegate: AnyObject {
    func didChangePassword(_ newPassword: String)
    func didChangeEmail(to newEmail: String)
    func error(_ error: Error)
}

class SettingsViewModel {
    
    private let database = DependencyContainer.shared.databaseManager
    
    private weak var delegate: SettingsDelegate? = nil
    
    func subscribe(_ delegate: SettingsDelegate) {
        self.delegate = delegate
    }
    
    func changeName(to username: String) {
        guard let uid = database.uid else { return }
        
        database.putData(path: "users/\(uid)", data: ["name": username])
    }
    
    func changeEmail(with password: String, to newEmail: String) {
        database.reauthenticateAndChangeEmail(password: password, newEmail: newEmail) { result in
            switch result {
            case .success(_):
                
                self.delegate?.didChangeEmail(to: newEmail)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
    
    func changePassword(from oldPassword: String, to newPassword: String) {
        database.updatePassword(from: oldPassword, to: newPassword) { result in
            switch result {
            case .success(_):
                
                self.delegate?.didChangePassword(newPassword)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
}
