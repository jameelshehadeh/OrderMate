//
//  Alertable.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    
    func showAlertInput(alertTitle: String,placeHolder: String,confirmTitle: String){
        AlertInputView.shared.show(onWindowOf: self.view, alertTitle: alertTitle, placeholder: placeHolder, confirmTitle: confirmTitle)
    }
    
}
