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
        )
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
        viewModel.getProgress()
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
    
    func didFetchName(_ model: ProfileCell.Item) {
        self.allCells.insert(.profile(model), at: 0)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFetchDailies(_ model: [DailyCell.Item]) {

        self.allCells.append(.entry(.init(entryName: "Daily Tasks")))
        self.allCells.append(.daily(model))
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFetchProgress(_ model: [ProgressCell.Item]) {
        
        self.allCells.append(.entry(.init(entryName: "Progress")))
        self.allCells.append(.progress(model))
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFetchQuest(_ model: QuestCell.Item) {
        self.allCells.append(.quest(model))
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func error(_ error: any Error) {
        print(error.localizedDescription)
    }
}
