//
//  LoginBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit

class LoginBuilder {
    func build() -> UIViewController {
        let viewModel = LoginViewModel()
        let vc = LoginVC(viewModel: viewModel)
        return vc
    }
}
