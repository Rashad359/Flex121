//
//  FoodCatologueCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 9/6/25.
//

import UIKit

protocol FoodCatalogueDelegate: AnyObject {
    func navigation()
}

class FoodCatalogueCell: UITableViewCell {
    
    private weak var delegate: FoodCatalogueDelegate? = nil
    
    private var items: [FoodCatalogue.Item] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 160, height: 196)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 24, bottom: 0, right: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(FoodCatalogue.self, forCellWithReuseIdentifier: FoodCatalogue.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    func subscribe(_ delegate: FoodCatalogueDelegate) {
        self.delegate = delegate
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(_ items: [FoodCatalogue.Item]) {
        self.items = items
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FoodCatalogueCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodCatalogue = collectionView.dequeueCell(for: indexPath)
        cell.configure(items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0)}
        let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: width, height: 196)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigation()
    }
}
