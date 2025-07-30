//
//  HorizontalFoodCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/26/25.
//

import UIKit

class HorizontalFoodCell: UITableViewCell {
    
    private var items: [AllFoodCell.Item] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.estimatedItemSize = CGSize(width: 243, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AllFoodCell.self, forCellWithReuseIdentifier: AllFoodCell.identifier)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(_ items: [AllFoodCell.Item]) {
        self.items = items
    }
}

extension HorizontalFoodCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AllFoodCell = collectionView.dequeueCell(for: indexPath)
        let item = items[indexPath.row]
        cell.configure(item)
        return cell
    }
}
