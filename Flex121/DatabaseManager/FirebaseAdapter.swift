//
//  FirebaseAdapter.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FirebaseAdapter: DBSession {
    
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    private var db = Firestore.firestore()
    
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
    
    func updatePassword(from oldPassword: String, to newPassword: String, completion: @escaping(Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser,
              let email = user.email else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)
        
        user.reauthenticate(with: credential) { result, error in
            if let error {
                print("Reauthentication failed", error.localizedDescription)
                return
            }
            
            user.updatePassword(to: newPassword) { error in
                if let error {
                    completion(.failure(error))
                }
                
                print("Updating to new password...")
                completion(.success(true))
            }
        }
    }
    
    func reauthenticateAndChangeEmail(password: String, newEmail: String, completion: @escaping(Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser,
              let email = user.email else { return }
        
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        user.reauthenticate(with: credential) { result, error in
            if let error {
                print("Reauthentication failed", error.localizedDescription)
                completion(.failure(error))
            }
            
            user.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                if let error {
                    print("coudn't update email", error.localizedDescription)
                    completion(.failure(error))
                }
                
                completion(.success(true))
                
                print("Email verification sent to \(newEmail)")
            }
        }
    }
    
    func putData(path: String, data: [String: Any]) {
        let docRef = db.document(path)
        docRef.setData(data, merge: true)
    }
    
    func fetchData(path: String, completion: @escaping(Result<[String: Any], Error>) -> ()) {
        let docRef = db.document(path)
        docRef.addSnapshotListener { snapshot, error in
            if let error {
                print("Something went wrong during fetching", error.localizedDescription)
                completion(.failure(error))
            }
            
            if let data = snapshot?.data() {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found or has no data."])))
            }
            
        }
    }
}
