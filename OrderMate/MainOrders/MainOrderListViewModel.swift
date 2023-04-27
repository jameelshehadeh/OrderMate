//
//  MainOrderListViewModel.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 27/04/2023.
//

import Foundation

class MainOrderListViewModel {
    
    private var orders = [Order](){
        didSet {
            didUpdateOrders()
        }
    }
    
    private var searchedOrders = [Order](){
        didSet {
            didUpdateOrders()
        }
    }
    
    var isSearching = false {
        didSet{
            didUpdateOrders()
        }
    }
    
    private var currentOrder = 0
    private let maxPreparingOrders = 3
    private let maxTotalOrders = 10
    
    var playSound : (IndexPath)->() = {_ in}
    
    var didUpdateOrders : ()->() = {}
    
    var showAlert : (String)->() = { _ in }
    
    var numberOfOrders: Int {
        return isSearching == true ? searchedOrders.count : orders.count
    }
    
    func order(at index: Int) -> Order {
        return isSearching == true ? searchedOrders[index] : orders[index]
    }
    
    func addOrder() {
        guard orders.count < maxTotalOrders else {
            showAlert("You cant add more than 10 orders at the same time.")
            return
        }
        
        currentOrder += 1
        
        let order = Order(orderNo: currentOrder, name: "Order no: \(currentOrder)", status: .new)
        
        orders.append(order)
    }
    
    func updateOrderStatus(at index: Int) {
        guard index >= 0 && index < orders.count else { return }
        
        let order = orders[index]
        
        switch order.status {
        case .new:
            canStartPreparingOrder() == true ? orders[index].status = .preparing : showAlert("Cant prepare more than 3 orders.")
        case .preparing:
            orders[index].status = .ready
        case .ready:
            orders[index].status = .delivered
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                self.removeDeliveredOrder(row:index,id: order.id)
            }
        case .delivered:
            break
        }
    }
    
    func canStartPreparingOrder() -> Bool {
        return orders.filter { $0.status == .preparing }.count < maxPreparingOrders
    }
    
    func removeDeliveredOrder(row: Int,id: String) {
        playSound(IndexPath(row: row, section: 0))
        orders.removeAll { $0.id == id }
    }
    
    func searchOrders(text: String){
        guard text.count > 0 else {
            isSearching = false
            return
        }
        isSearching = true
        searchedOrders = orders.filter { $0.name.contains(text) || "\($0.orderNo)" == text }
    }
    
}






