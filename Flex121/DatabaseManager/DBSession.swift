//
//  DBSession.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit

protocol DBSession {
    func logIn(with email: String, password: String, completion: @escaping(Result<Bool, Error>) -> ())
    func signUp(with email: String, password: String, completion: @escaping(Result<Bool, Error>) -> ())
}
