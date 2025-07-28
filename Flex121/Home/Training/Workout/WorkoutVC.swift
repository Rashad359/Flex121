//
//  WorkoutVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/24/25.
//

import UIKit

final class WorkoutVC: BaseViewController {
    
    enum CellHandler {
        case timer
        case title(WorkoutTitleCell.Item)
        case workout(WorkoutsCell.Item)
    }
    
    private var allCells: [CellHandler] = [
        .timer,
        .title(.init(title: "Workout")),
        .workout(.init(title: "Cardio", subtitle: "7 Exercises > 10 min", workoutImage: .workout1)),
        .workout(.init(title: "Chest Workout", subtitle: "15 Exercises > 10 min", workoutImage: .workout2)),
        .workout(.init(title: "Chest Workout", subtitle: "15 Exercises > 10 min", workoutImage: .workout3)),
        .workout(.init(title: "Chest Workout", subtitle: "15 Exercises > 10 min", workoutImage: .workout4))
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.identifier)
        tableView.register(WorkoutTitleCell.self, forCellReuseIdentifier: WorkoutTitleCell.identifier)
        tableView.register(WorkoutsCell.self, forCellReuseIdentifier: WorkoutsCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension WorkoutVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .timer:
            let cell: TimerCell = tableView.dequeueCell(for: indexPath)
            return cell
        case .title(let model):
            let cell: WorkoutTitleCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .workout(let model):
            let cell: WorkoutsCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
}
