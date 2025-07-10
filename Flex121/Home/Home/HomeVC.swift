//
//  HomeVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

class HomeVC: BaseViewController {
    
    enum CellHandler {
        case profile(ProfileCell.Item)
        case entry(EntryCell.Item)
        case calendar([CalendarCell.Item])
        case daily([DailyCell.Item])
        case progress([ProgressCell.Item])
    }
    
    private var allCells: [CellHandler] = [
        .profile(.init(profileImage: .genericUser, username: "Sam Height", dailyMessage: "Good morning.")),
        .entry(.init(entryName: "Calendar")),
        .calendar([
            .init(
                date: "14",
                dayOfWeek: "Sun"
            ),
            .init(
                date: "15",
                dayOfWeek: "Mon"
            ),
            .init(
                date: "16",
                dayOfWeek: "Tue"
            ),
            .init(
                date: "17",
                dayOfWeek: "Wed"
            ),
            .init(
                date: "18",
                dayOfWeek: "Thu"
            ),
            .init(
                date: "19",
                dayOfWeek: "Fri"
            ),
            .init(
                date: "20",
                dayOfWeek: "Sat"
            ),
            ]
        ),
        .entry(.init(entryName: "Daily Tasks")),
        .daily([
            .init(
                titleName: "Breakfast",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .salad,
                backgroundColor: .softCyan
            ),
            .init(
                titleName: "Breakfast",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .treadmill,
                backgroundColor: .softYellow
            ),
            .init(
                titleName: "Breakfast",
                amountOfCalories: "450 Calories",
                timeForPrep: "9:00 am",
                taskImage: .redSalad,
                backgroundColor: .softPink
            ),
            .init(
                titleName: "Breakfast",
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
        )
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        collectionView.register(EntryCell.self, forCellWithReuseIdentifier: EntryCell.identifier)
        collectionView.register(HorizontalCalendarCell.self, forCellWithReuseIdentifier: HorizontalCalendarCell.identifier)
        collectionView.register(HorizontalDailyCell.self, forCellWithReuseIdentifier: HorizontalDailyCell.identifier)
        collectionView.register(VerticalProgressCell.self, forCellWithReuseIdentifier: VerticalProgressCell.identifier)
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: collectionView.frame.width, height: 100)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupUI() {
        tabBarController?.view.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCells = allCells[indexPath.row]
        switch myCells {
        case .profile(let model):
            let cell: ProfileCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .entry(let model):
            let cell: EntryCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .calendar(let model):
            let cell: HorizontalCalendarCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: model)
            return cell
        case .daily(let model):
            let cell: HorizontalDailyCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .progress(let model):
            let cell: VerticalProgressCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
}
