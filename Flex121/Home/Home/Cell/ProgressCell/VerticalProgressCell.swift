//
//  VerticalProgressCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/10/25.
//

import UIKit

class VerticalProgressCell: UICollectionViewCell {
    
    private var items: [ProgressCell.Item] = []
    
    private lazy var progressCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 9
        layout.minimumLineSpacing = 9
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 26, bottom: 20, right: 26)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProgressCell.self, forCellWithReuseIdentifier: ProgressCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(progressCollectionView)
        progressCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(_ items: [ProgressCell.Item]) {
        self.items = items
    }
}

extension VerticalProgressCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProgressCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(items[indexPath.row])
        return cell
    }
}
