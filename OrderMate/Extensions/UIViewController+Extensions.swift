//
//  UIViewController+Extensions.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import UIKit

extension UIViewController {
    
    typealias TitleTextAttributes = [NSAttributedString.Key : Any]
    func setNavBarAppearance(bgColor: UIColor = .systemBackground , titleAtts: TitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.purple]){
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = bgColor
        navBarAppearance.titleTextAttributes = titleAtts
        navBarAppearance.largeTitleTextAttributes = titleAtts
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
    }
    
    func push(_ vc: UIViewController){
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


