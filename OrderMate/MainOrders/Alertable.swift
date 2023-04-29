//
//  Alertable.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    
    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
}
