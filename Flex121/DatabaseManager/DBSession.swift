//
//  DBSession.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit

protocol DBSession {
    var uid: String? { get } 
    func logIn(with email: String, password: String, completion: @escaping(Result<Bool, Error>) -> ())
    func signUp(with email: String, password: String, completion: @escaping(Result<Bool, Error>) -> ())
    func putData(path: String, data: [String: Any])
    func fetchData(path: String, completion: @escaping(Result<[String: Any], Error>) -> ())
    func reauthenticateAndChangeEmail(password: String, newEmail: String)
}
