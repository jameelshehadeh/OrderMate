//
//  Order.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 27/04/2023.
//

import Foundation

struct Order {
    let name: String
    let createdTime = Date().timeIntervalSince1970
    var status: OrderStatus
}

enum OrderStatus : String{
    case new = "New"
    case preparing = "Preparing"
    case ready = "Ready"
    case delivered = "Delivered"
}
