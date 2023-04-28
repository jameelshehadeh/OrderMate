//
//  DeliveredOrdersViewModel.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import Foundation

class DeliveredOrdersViewModel {
    
     var orders : [Order]{
         return ArchivedOrdersData.shared.orders
    }
    
    var numberOfOrders: Int {
        return orders.count
    }
    
    func order(at index: Int) -> Order {
        return orders[index]
    }
    
}
