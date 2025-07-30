//
//  HomeViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didFetchName(data: [String: Any])
    func didFetchDailies(data: [String: Any])
    func didFetchQuest(data: [String: Any])
    func error(_ error: Error)
}

class HomeViewModel {
    private let coordinator: HomeCoordinator
    
    private let database = DependencyContainer.shared.databaseManager
    
    private weak var delegate: HomeViewDelegate? = nil
    
    func subscribe(_ delegate: HomeViewDelegate) {
        self.delegate = delegate
    }
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToProfile() {
        coordinator.openProfile()
    }
    
    func getName() {
        guard let uid = database.uid else { return }

        database.fetchData(path: "users/\(uid)") { result in
            switch result {
            case .success(let data):
                
                self.delegate?.didFetchName(data: data)
                
            case .failure(let error):
                
                self.delegate?.error(error)

            }
        }
    }
    
    func getDailies() {
        database.fetchData(path: "dailytasks/dailies") { result in
            switch result {
            case .success(let data):
                
                self.delegate?.didFetchDailies(data: data)
                
            case .failure(let error):
                
                self.delegate?.error(error)
            }
        }
    }
    
    func getQuest() {
        database.fetchData(path: "dailytasks/progress") { result in
            switch result {
            case .success(let data):
                
                self.delegate?.didFetchQuest(data: data)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
}
