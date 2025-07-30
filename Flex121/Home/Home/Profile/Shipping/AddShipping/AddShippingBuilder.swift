//
//  AddShippingBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class AddShippingBuilder {
    func build() -> UIViewController {
        let viewModel = AddShippingViewModel()
        let vc = AddShippingVC(viewModel: viewModel)
        return vc
    }
}
