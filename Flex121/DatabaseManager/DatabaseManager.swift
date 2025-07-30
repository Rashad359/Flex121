//
//  FirebaseManager.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit
import FirebaseAuth

class DatabaseManager {
    
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
//    static let shared = DatabaseManager(service: FirebaseAdapter())
    
    private let service: DBSession
    
    init(service: DBSession) {
        self.service = service
    }
    
    func logIn(with email: String, password: String, completion: @escaping(Result<Bool, Error>) -> ()) {
        service.logIn(with: email, password: password, completion: completion)
    }
    
    func signUp(with email: String, password: String, completion: @escaping(Result<Bool, Error>) -> ()) {
        service.signUp(with: email, password: password, completion: completion)
    }
    
    func putData(path: String, data: [String: Any]) {
        service.putData(path: path, data: data)
    }
    
    func fetchData(path: String, completion: @escaping(Result<[String: Any], Error>) -> ()) {
        service.fetchData(path: path, completion: completion)
    }
    
    func reauthenticateAndChangeEmail(password: String, newEmail: String) {
        service.reauthenticateAndChangeEmail(password: password, newEmail: newEmail)
    }
}
