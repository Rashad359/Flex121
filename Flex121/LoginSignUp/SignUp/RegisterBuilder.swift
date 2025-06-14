//
//  RegisterBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/14/25.
//

import UIKit

class RegisterBuilder {
    func build() -> UIViewController {
        let viewModel = RegisterScreenViewModel()
        let vc = RegisterScreenVC(viewModel: viewModel)
        return vc
    }
}
