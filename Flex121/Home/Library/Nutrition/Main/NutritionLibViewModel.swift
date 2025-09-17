//
//  NutritionLibViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 8/21/25.
//

import UIKit

protocol NutritionLibDelegate: AnyObject {
    func didFetchCategories()
    func error(_ error: Error)
}

class NutritionLibViewModel {
    private let coordinator: HomeCoordinator
    
    private weak var delegate: NutritionLibDelegate?
    
    private let database = DependencyContainer.shared.databaseManager
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToDetails() {
        coordinator.navigateToDetails()
    }
    
    func subscribe(_ delegate: NutritionLibDelegate) {
        self.delegate = delegate
    }
    
    func getCategories() {
        database.fetchData(path: "mealCategory/meals") { result in
            switch result {
            case .success(let data):
                guard let mealType = data["mealType"] as? [String] else { return }
                print(data)
                print(mealType)
            case .failure(let error):
                print(error)
            }
        }
    }
}
