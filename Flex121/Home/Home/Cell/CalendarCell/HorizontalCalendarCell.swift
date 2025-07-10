//
//  HorizontalCalendarCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/10/25.
//

import UIKit

class HorizontalCalendarCell: UICollectionViewCell {

    private var items: [CalendarCell.Item] = []
    private var selectedIndex: Int = 0

    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.estimatedItemSize = CGSize(width: 50, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(calendarCollectionView)
        calendarCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(70)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with items: [CalendarCell.Item], selectedIndex: Int = 2) {
        self.items = items
        self.selectedIndex = selectedIndex
        calendarCollectionView.reloadData()
    }
}

extension HorizontalCalendarCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let item = items[indexPath.item]
        cell.configure(item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 80)
    }
}

