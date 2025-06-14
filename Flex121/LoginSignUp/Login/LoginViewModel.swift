//
//  LoginViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit
class LoginViewModel {
    func goToWebsite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
