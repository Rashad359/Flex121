//
//  HomeCoordinator.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/15/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeController(coordinator: self)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func navigateToSettings() {
        let settingsVC = SettingsVC()
        self.navigationController.pushViewController(settingsVC, animated: true)
    }
    
    func openProfile() {
        let profileVC = ProfileBuilder(coordinator: self).build()
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func navigateToOrders() {
        let ordersVC = MyOrdersVC()
        navigationController.pushViewController(ordersVC, animated: true)
    }
    
    func navigateToShipping() {
        let shippingVC = ShippingBuilder(coordinator: self).build()
        navigationController.pushViewController(shippingVC, animated: true)
    }
    
    func navigateToAddShipping() {
        let addShipVC = AddShippingBuilder().build()
        navigationController.pushViewController(addShipVC, animated: true)
    }
    
    func navigateToPayment() {
        let paymentVC = PaymentBuilder(coordinator: self).build()
        navigationController.pushViewController(paymentVC, animated: true)
    }
    
    func navigateToAddPayment() {
        let addPaymentVC = AddPaymentBuilder(coordinator: self).build()
        navigationController.pushViewController(addPaymentVC, animated: true)
    }
}
