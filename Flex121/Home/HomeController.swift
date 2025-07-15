//
//  HomeController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

class HomeController: UITabBarController {
    
    private let userDefaults = UserDefaultsManager.shared
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        userDefaults.login(with: true)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabbarBackground
        appearance.stackedLayoutAppearance.selected.iconColor = .main
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.main]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.backgroundColor = .tabbarBackground
        self.tabBar.tintColor = .main
        self.tabBar.unselectedItemTintColor = .white
    }
    
    private func setupTabs() {
        
        
        let home = self.createNav(with: "Home", and: .home, vc: HomeBuilder(coordinator: coordinator).build())
        let training = self.createNav(with: "Training", and: .dumbbell, vc: TrainingVC())
        let progress = self.createNav(with: "Progress", and: .diagram, vc: ProgressVC())
        let services = self.createNav(with: "Services", and: .shop, vc: ServicesVC())
        let library = self.createNav(with: "Library", and: .heart, vc: LibraryVC())
        
        self.setViewControllers([home, training, progress, services, library], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
