//
//  TrainersVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/8/25.
//

import UIKit

class TrainersVC: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TrainersCell.self, forCellWithReuseIdentifier: TrainersCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    private let startButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .main
        button.titleLabel?.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 17)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: collectionView.frame.width - 50, height: 97)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupUI() {
        title = "Trainers"
        [collectionView, startButton].forEach(view.addSubview)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.width.greaterThanOrEqualTo(124)
        }
    }
}

extension TrainersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainersCell.identifier, for: indexPath) as? TrainersCell else { return UICollectionViewCell() }
        cell.configure(.init(rating: "4.8", category: "Hight intensity Training ", experience: "4 years experience", trainerImage: .lifting, trainerName: "Richard Will"))
        return cell
    }
}
