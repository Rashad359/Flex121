//
//  HorizontalMetricsCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/15/25.
//

import UIKit

class HorizontalMetricsCell: UITableViewCell {
    
    private var items: [MetricsCell.Item] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 9
        layout.estimatedItemSize = CGSize(width: 103, height: 66)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 25)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MetricsCell.self, forCellWithReuseIdentifier: MetricsCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
//            make.edges.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(_ items: [MetricsCell.Item]) {
        self.items = items
        self.collectionView.reloadData()
    }
}

extension HorizontalMetricsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MetricsCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(items[indexPath.row])
        return cell
    }
    
    
}
