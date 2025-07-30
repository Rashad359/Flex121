//
//  TrainingVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit
import SnapKit


class TrainingVC: BaseViewController {
    
    private var currentIndex: Int = 0
    
    private lazy var pages: [UIViewController] = [
        NutritionVC(),
        WorkoutVC()
    ]
    
    private lazy var nutritionButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitle("Nutrition", for: .normal)
        button.layer.borderWidth = 0
        button.backgroundColor = .main
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(didTapNutrition), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var workoutButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitle("Workout", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(didTapWorkout), for: .touchUpInside)
        
        return button
    }()
    
//    private lazy var timelineButton: BaseButton = {
//        let button = BaseButton(type: .system)
//        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        button.setTitle("Timeline", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        button.addTarget(self, action: #selector(didTapTimeLine), for: .touchUpInside)
//        
//        return button
//    }()
    
    private let topStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    private lazy var pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.setViewControllers([pages[0]], direction: .forward, animated: true)
        return pageController
    }()
    
    @objc
    private func didTapNutrition() {
//        pageController.setViewControllers([pages[0]], direction: .forward, animated: true)
//        nutritionButton.backgroundColor = .main
//        nutritionButton.layer.borderWidth = 0
//        
//        workoutButton.backgroundColor = .clear
//        workoutButton.layer.borderWidth = 1
        
        switchPage(to: 0)
        updateAppearance(selected: 0)
    }
    
    @objc
    private func didTapWorkout() {
//        pageController.setViewControllers([pages[1]], direction: .forward, animated: true)
//        workoutButton.backgroundColor = .main
//        workoutButton.layer.borderWidth = 0
//        
//        nutritionButton.backgroundColor = .clear
//        nutritionButton.layer.borderWidth = 1
        
        switchPage(to: 1)
        updateAppearance(selected: 1)
    }
    
//    @objc
//    private func didTapTimeLine() {
//        
//    }
    
    private func switchPage(to index: Int) {
        guard index != currentIndex else { return }
        
        let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse
        pageController.setViewControllers([pages[index]], direction: direction, animated: true)
        currentIndex = index
    }
    
    private func updateAppearance(selected index: Int) {
        let selectedColor = UIColor.main
        let deselectedColor = UIColor.clear
        
        [nutritionButton, workoutButton].enumerated().forEach { i, button in
            if i == index {
                button.backgroundColor = selectedColor
                button.layer.borderWidth = 0
            } else {
                button.backgroundColor = deselectedColor
                button.layer.borderWidth = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Daily tasts"
        
        view.addSubview(topStackView)
        [nutritionButton, workoutButton].forEach(topStackView.addArrangedSubview)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        
        pageController.view.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
