//
//  ViewController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit

class OnboardingVC: BaseViewController {
    
    private let items: [OnboardingCell.Item] = [
        .init(
            image: .dumbells,
            title: "Meet your coach,start your journey WITH FLEX 121".uppercased(),
            isButtonHidden: true
        ),
        .init(
            image: .lifting,
            title: "Create a workout plan to stay fit".uppercased(),
            isButtonHidden: true
        ),
        .init(
            image: .running,
            title: "No more excuses, do it now".uppercased(),
            isButtonHidden: false
        ),
        
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .background
        collectionView.alwaysBounceVertical = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
//        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //For finding needed fonts
//        for family in UIFont.familyNames {
//            print("family:", family)
//            for font in UIFont.fontNames(forFamilyName: family) {
//                print("font:", font)
//            }
//        } 
        
        edgesForExtendedLayout = []
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    private func setupUI() {
        [collectionView, pageControl].forEach { component in
            view.addSubview(component)
        }
        
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
            
            
        ])
    }

    override func viewDidLayoutSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }

}


extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.configure(items[indexPath.row])
        cell.goToLogin = {[weak self] in
            let vc = LoginViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        pageControl.currentPage = Int(offset) / Int(width)
    }
}
