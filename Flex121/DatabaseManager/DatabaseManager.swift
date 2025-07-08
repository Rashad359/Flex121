//
//  FirebaseManager.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit
import FirebaseAuth

class DatabaseManager {
    static let shared = DatabaseManager(service: FirebaseAdapter())
    
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
}
