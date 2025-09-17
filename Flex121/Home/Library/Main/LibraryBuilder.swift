//
//  LibraryBuilder.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 8/21/25.
//

import UIKit

class LibraryBuilder {
    
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = LibraryViewModel(coordinator: coordinator)
        let vc = LibraryVC(viewModel: viewModel)
        return vc
    }
}
