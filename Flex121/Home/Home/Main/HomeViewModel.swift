//
//  HomeViewModel.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didFetchName(_ model: ProfileCell.Item)
    func didFetchDailies(_ model: [DailyCell.Item])
    func didFetchQuest(_ model: QuestCell.Item)
    func didFetchProgress(_ model: [ProgressCell.Item])
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
                
                let model = self.mapDataToProfileItem(data)
                self.delegate?.didFetchName(model)
                
            case .failure(let error):
                
                self.delegate?.error(error)

            }
        }
    }
    
    func getDailies() {
        database.fetchData(path: "dailytasks/dailies") { result in
            switch result {
            case .success(let data):
                
                let model = self.mapDataToDailiesItem(data)
                self.delegate?.didFetchDailies(model)
                
            case .failure(let error):
                
                self.delegate?.error(error)
            }
        }
    }
    
    func getProgress() {
        database.fetchData(path: "progress/components") { result in
            switch result {
            case .success(let data):
                
                let model = self.mapDataToProgressItem(data)
                self.delegate?.didFetchProgress(model)
                print(data)
                print(model)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
    
    func getQuest() {
        database.fetchData(path: "dailytasks/progress") { result in
            switch result {
            case .success(let data):
                
                let model = self.mapDataToQuestItem(data)
                self.delegate?.didFetchQuest(model)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
    
    func mapDataToProfileItem(_ data: [String: Any]) -> ProfileCell.Item {
        return .init(
            profileImage: .genUser,
            username: data["name"] as? String ?? "",
            dailyMessage: "Good morning"
        )
    }
    
    func mapDataToQuestItem(_ data: [String: Any]) -> QuestCell.Item {
        return .init(
            stepsLeft: data["stepsLeft"] as? Int ?? 0,
            totalSteps: data["stepsTotal"] as? Int ?? 0
        )
    }
    
    func mapDataToDailiesItem(_ data: [String: Any]) -> [DailyCell.Item] {
        let images: [UIImage] = [
            .salad,
            .treadmill,
            .redSalad,
            .lifter
        ]
        
        let colors: [UIColor] = [
            .softCyan,
            .softYellow,
            .softPink,
            .softCoral
        ]
        
        guard let activity = data["activity"] as? [String],
              let payoff = data["payoff"] as? [String],
              let time = data["time"] as? [String] else { return [] }
        
        let result = (0..<activity.count).map { i in
            return DailyCell.Item(
                titleName: activity[i],
                amountOfCalories: payoff[i],
                timeForPrep: time[i],
                taskImage: images[i],
                backgroundColor: colors[i]
            )
        }
        
        return result
    }
    
    func mapDataToProgressItem(_ data: [String: Any]) -> [ProgressCell.Item] {
        
        let colors: [UIColor] = [
            .softCoral,
            .softGreen,
            .softBlue,
            .brightGreen,
            .softRed,
            .main
        ]
        
        guard let title = data["title"] as? [String],
              let measure = data["measure"] as? [String],
              let amount = data["amount"] as? [String] else { return [] }
        
        let result = (0..<title.count).map { i in
            return ProgressCell.Item(
                title: title[i],
                amount: amount[i],
                measure: measure[i],
                mainColor: colors[i]
            )
        }
        return result
    }
}
