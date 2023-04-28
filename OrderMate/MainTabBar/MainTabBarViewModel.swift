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
        
        let viewModel = MainOrderListViewModel()
        let mainOrdersNavVC = UINavigationController(rootViewController: MainOrdersListVC(viewModel: viewModel))
        
        let mainOrdersTabBarItem = UITabBarItem(title: "Main Orders", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
        mainOrdersNavVC.tabBarItem = mainOrdersTabBarItem
        
        return mainOrdersNavVC
    }
    
    private func prepareDeliveredOrdersListVC() -> UINavigationController {
        let dataArchiver = ArchivedOrdersData.shared
        let viewModel = DeliveredOrdersViewModel(archiver: dataArchiver)
        
        let deliveredOrdersNavVC = UINavigationController(rootViewController: DeliveredOrdersListVC(viewModel: viewModel))
        
        let oldOrdersTabBarItem = UITabBarItem(title: "Delivered Orders", image: UIImage(systemName: "checkmark.rectangle.fill"), selectedImage: nil)
        deliveredOrdersNavVC.tabBarItem = oldOrdersTabBarItem
        
        return deliveredOrdersNavVC
    }
  
    
}
