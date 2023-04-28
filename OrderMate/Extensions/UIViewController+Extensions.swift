//
//  UIViewController+Extensions.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import UIKit

extension UIViewController {
    
    func setNavBarAppearance(bgColor: UIColor = .systemBackground , titleAtts: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.purple]){
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = bgColor
        navBarAppearance.titleTextAttributes = titleAtts
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
    }
    
}


