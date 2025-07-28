//
//  NutritionVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/24/25.
//

import UIKit

class NutritionVC: BaseViewController {
    
    enum CaseHandler {
        case progress
        case waterCategory
        case title(TrainingTitleCell.Item)
        case category(TrainingCategoryCell.Item)
    }
    
    private var allCases: [CaseHandler] = [
        .progress,
        .waterCategory,
        .title(.init(title: "Daily Meals")),
        .category(
            .init(
                mainColor: .softPink,
                titleText: "Breakfast",
                amount: "360 Kcal",
                subtitle: "Recomended 447 Kcal"
            )
        ),
        .category(
            .init(
                mainColor: .softBlue,
                titleText: "Lunch",
                amount: "360 Kcal",
                subtitle: "Recomended 447 Kcal"
            )
        ),
        .category(
            .init(
                mainColor: .softCoral,
                titleText: "Dinner",
                amount: "360 Kcal",
                subtitle: "Recomended 447 Kcal"
            )
        ),
        .category(
            .init(
                mainColor: .softGreen,
                titleText: "Snack",
                amount: "360 Kcal",
                subtitle: "Recomended 447 Kcal"
            )
        )
    ]
    
//    private lazy var nutritionButton: BaseButton = {
//        let button = BaseButton(type: .system)
//        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        button.setTitle("Nutrition", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        button.addTarget(self, action: #selector(didTapNutrition), for: .touchUpInside)
//        
//        return button
//    }()
//    
//    private lazy var workoutButton: BaseButton = {
//        let button = BaseButton(type: .system)
//        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        button.setTitle("Workout", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        button.addTarget(self, action: #selector(didTapWorkout), for: .touchUpInside)
//        
//        return button
//    }()
//    
//    private lazy var timelineButton: BaseButton = {
//        let button = BaseButton(type: .system)
//        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        button.setTitle("Timeline", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        button.addTarget(self, action: #selector(didTapTimeLine), for: .touchUpInside)
//        
//        return button
//    }()
    
//    private let topStackView: BaseHorizontalStackView = {
//        let stackView = BaseHorizontalStackView()
//        stackView.distribution = .fillEqually
//        stackView.spacing = 9
//        return stackView
//    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(DailyProgressCell.self, forCellReuseIdentifier: DailyProgressCell.identifier)
        tableView.register(WaterCategoryCell.self, forCellReuseIdentifier: WaterCategoryCell.identifier)
        tableView.register(TrainingTitleCell.self, forCellReuseIdentifier: TrainingTitleCell.identifier)
        tableView.register(TrainingCategoryCell.self, forCellReuseIdentifier: TrainingCategoryCell.identifier)
        
        return tableView
    }()
    
//    @objc
//    private func didTapNutrition() {
//        
//    }
//    
//    @objc
//    private func didTapWorkout() {
//        
//    }
//    
//    @objc
//    private func didTapTimeLine() {
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Daily tasks"
//        view.addSubview(topStackView)
        view.addSubview(tableView)
//        [nutritionButton, workoutButton, timelineButton].forEach(topStackView.addArrangedSubview)
        
//        topStackView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
//            make.horizontalEdges.equalToSuperview().inset(24)
//        }
        
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(topStackView.snp.bottom).offset(0)
            make.top.equalToSuperview().offset(0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NutritionVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = allCases[indexPath.row]
        switch myCell {
        case .progress:
            let cell: DailyProgressCell = tableView.dequeueCell(for: indexPath)
            return cell
        case .waterCategory:
            let cell: WaterCategoryCell = tableView.dequeueCell(for: indexPath)
            return cell
        case .title(let model):
            let cell: TrainingTitleCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .category(let model):
            let cell: TrainingCategoryCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
        
    }
}
