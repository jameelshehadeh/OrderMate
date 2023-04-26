//
//  MainTabBarController.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 26/04/2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    let viewModel = MainTabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        viewModel.instantiateControllers()
        configureTabBar()
    }
    
    func bindData(){
        
        viewModel.didUpdateControllers = { [weak self] in
            guard let self else {return}
            self.viewControllers = self.viewModel.viewControllers
        }
        
    }
    
    func configureTabBar(){
        tabBar.backgroundColor = .systemBackground
    }

    

}
