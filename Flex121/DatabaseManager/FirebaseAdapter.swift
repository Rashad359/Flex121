//
//  FirebaseAdapter.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit
import FirebaseAuth

class FirebaseAdapter: DBSession {
    func logIn(with email: String, password: String, completion: @escaping(Result<Bool, any Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
            }
            completion(.success(true))
        }
    }
    
    func signUp(with email: String, password: String, completion: @escaping(Result<Bool, any Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
            }
            completion(.success(true))
        }
    }
}
