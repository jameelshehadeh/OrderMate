//
//  MainTabBarViewModel.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 26/04/2023.
//

import UIKit

class MainTabBarViewModel {
    
    var viewControllers: [UIViewController] = [] {
        didSet {
            didUpdateControllers()
        }
    }
    
    var didUpdateControllers : (()->()) = {}
 
    func instantiateControllers() {
        let tabs = [prepareMainOrdersListVC(),prepareDeliveredOrdersListVC()]
        viewControllers = tabs
    }
    
    private func prepareMainOrdersListVC() -> UINavigationController {
        
        let mainOrdersNavVC = UINavigationController(rootViewController: MainOrdersListVC())
        
        let mainOrdersTabBarItem = UITabBarItem(title: "Main Orders", image: UIImage(systemName: "list.bullet.clipboard.fill"), selectedImage: nil)
        mainOrdersNavVC.tabBarItem = mainOrdersTabBarItem
        
        return mainOrdersNavVC
    }
    
    private func prepareDeliveredOrdersListVC() -> UINavigationController {
        
        let deliveredOrdersNavVC = UINavigationController(rootViewController: DeliveredOrdersListVC())
        
        let oldOrdersTabBarItem = UITabBarItem(title: "Delivered Orders", image: UIImage(systemName: "checklist.checked"), selectedImage: nil)
        deliveredOrdersNavVC.tabBarItem = oldOrdersTabBarItem
        
        return deliveredOrdersNavVC
    }
  
    
}
