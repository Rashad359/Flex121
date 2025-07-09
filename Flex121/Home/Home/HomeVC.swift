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
        case calendarEntry
    }
    
    private var allCells: [CellHandler] = [
        .profile(.init(profileImage: .genericUser, username: "Sam Height", dailyMessage: "Good morning.")),
        .calendarEntry
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        collectionView.register(CalendarEntryCell.self, forCellWithReuseIdentifier: CalendarEntryCell.identifier)
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
//        layout.itemSize = CGSize(width: collectionView.frame.width, height: 48)
        layout.estimatedItemSize = CGSize(width: collectionView.frame.width, height: 100)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 25)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        case .calendarEntry:
            let cell: CalendarEntryCell = collectionView.dequeueCell(for: indexPath)
            return cell
        }
    }
}
