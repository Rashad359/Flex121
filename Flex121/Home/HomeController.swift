//
//  HomeController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

class HomeController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTabs()
        
        self.tabBar.backgroundColor = .tabbarBackground
        self.tabBar.tintColor = .main
        self.tabBar.unselectedItemTintColor = .white
    }
    
    private func setupTabs() {
        
        let home = self.createNav(with: "Home", and: .home, vc: HomeVC())
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


