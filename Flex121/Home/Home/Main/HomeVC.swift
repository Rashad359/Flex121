//
//  HomeVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeVC: BaseViewController {
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    enum CellHandler {
        case profile(ProfileCell.Item)
        case entry(EntryCell.Item)
        case calendar([CalendarCell.Item])
        case daily([DailyCell.Item])
        case progress([ProgressCell.Item])
        case quest(QuestCell.Item)
    }
    
    private var allCells: [CellHandler] = [
        .profile(.init(profileImage: .genericUser, username: "Sam Height", dailyMessage: "Good morning.")),
        .entry(.init(entryName: "Calendar")),
        .calendar([
            .init(
                date: "\(AppDate.getDay())",
                dayOfWeek: AppDate.getWeekday()
            ),
            .init(
                date: "\(AppDate.getDay(offset: 1))",
                dayOfWeek: AppDate.getWeekday(offset: 1)
            ),
            .init(
                date: "\(AppDate.getDay(offset: 2))",
                dayOfWeek: AppDate.getWeekday(offset: 2)
            ),
            .init(
                date: "\(AppDate.getDay(offset: 3))",
                dayOfWeek: AppDate.getWeekday(offset: 3)
            ),
            .init(
                date: "\(AppDate.getDay(offset: 4))",
                dayOfWeek: AppDate.getWeekday(offset: 4)
            ),
            .init(
                date: "\(AppDate.getDay(offset: 5))",
                dayOfWeek: AppDate.getWeekday(offset: 5)
            ),
            .init(
                date: "\(AppDate.getDay(offset: 6))",
                dayOfWeek: AppDate.getWeekday(offset: 6)
            ),
            ]
        ),
        .entry(.init(entryName: "Daily Tasks")),
        .daily([
            .init(
                titleName: "dinner",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .salad,
                backgroundColor: .softCyan
            ),
            .init(
                titleName: "Dinner",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .treadmill,
                backgroundColor: .softYellow
            ),
            .init(
                titleName: "Dinner",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .redSalad,
                backgroundColor: .softPink
            ),
            .init(
                titleName: "Dinner",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .lifter,
                backgroundColor: .softCoral
            )
        ]
        ),
        .entry(.init(entryName: "Progress")),
        .progress(
            [
                .init(
                    title: "Calories",
                    amount: "1200",
                    measure: "kcal",
                    mainColor: .softCoral
                ),
                .init(
                    title: "Activities",
                    amount: "1.2K",
                    measure: "Steps",
                    mainColor: .softGreen
                ),
                .init(
                    title: "Water",
                    amount: "0.9",
                    measure: "liters",
                    mainColor: .softBlue
                ),
                .init(
                    title: "Protein",
                    amount: "53",
                    measure: "grams",
                    mainColor: .brightGreen
                ),
                .init(
                    title: "Carbs",
                    amount: "175",
                    measure: "grams",
                    mainColor: .softRed
                ),
                .init(
                    title: "Fats",
                    amount: "28",
                    measure: "grams",
                    mainColor: .main
                )
            ]
        ),
        .quest(.init(stepsLeft: 3220, totalSteps: 10000))
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.register(EntryCell.self, forCellReuseIdentifier: EntryCell.identifier)
        tableView.register(HorizontalCalendarCell.self, forCellReuseIdentifier: HorizontalCalendarCell.identifier)
        tableView.register(HorizontalDailyCell.self, forCellReuseIdentifier: HorizontalDailyCell.identifier)
        tableView.register(VerticalProgressCell.self, forCellReuseIdentifier: VerticalProgressCell.identifier)
        tableView.register(QuestCell.self, forCellReuseIdentifier: QuestCell.identifier)
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []
        setupUI()
        viewModel.subscribe(self)
        viewModel.getName()
        viewModel.getDailies()
        viewModel.getQuest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        tabBarController?.view.backgroundColor = .background
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCells = allCells[indexPath.row]
        switch myCells {
        case .profile(let model):
            let cell: ProfileCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            cell.subscribe(self)
            return cell
        case .entry(let model):
            let cell: EntryCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .calendar(let model):
            let cell: HorizontalCalendarCell = tableView.dequeueCell(for: indexPath)
            cell.configure(with: model)
            return cell
        case .daily(let model):
            let cell: HorizontalDailyCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .progress(let model):
            let cell: VerticalProgressCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .quest(let model):
            let cell: QuestCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
    
    
}

extension HomeVC: ProfileCellDelegate {
    func openProfile() {
        viewModel.goToProfile()
    }
}

extension HomeVC: HomeViewDelegate {
    func didFetchQuest(data: [String : Any]) {
        guard let stepsLeft = data["stepsLeft"] as? Int,
              let totalSteps = data["stepsTotal"] as? Int else { return }
        
        if let index = self.allCells.firstIndex(where: {
            if case .quest = $0 { return true }
            return false
        }) {
            if case .quest(var model) = self.allCells[index] {
                model.stepsLeft = stepsLeft
                model.totalSteps = totalSteps
                self.allCells[index] = .quest(model)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFetchName(data: [String : Any]) {
        guard let name = data["name"] as? String else { return }
        
        if let index = self.allCells.firstIndex(where: {
            if case .profile = $0 { return true }
            return false
        }) {
            if case .profile(var model) = self.allCells[index] {
                model.username = name
                self.allCells[index] = .profile(model)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFetchDailies(data: [String : Any]) {
        guard let activity = data["activity"] as? [String],
              let payoff = data["payoff"] as? [String],
              let time = data["time"] as? [String] else { return }
        
        if let index = self.allCells.firstIndex(where: {
            if case .daily = $0 { return true }
            return false
        }) {
            if case .daily(var model) = self.allCells[index] {
                for index in 0...model.count - 1 {
                    model[index].titleName = activity[index]
                    model[index].amountOfCalories = payoff[index]
                    model[index].timeForPrep = time[index]
                }
                self.allCells[index] = .daily(model)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func error(_ error: any Error) {
        print(error.localizedDescription)
    }
}
