//
//  ArchivedOrdersData.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import Foundation

class ArchivedOrdersData {
    
    static let shared = ArchivedOrdersData()
    
    private init(){}
    
    var orders: [Order] = [] {
           didSet {
               NotificationCenter.default.post(name: .init("OrdersChanged"), object: nil)
           }
       }
    
}
