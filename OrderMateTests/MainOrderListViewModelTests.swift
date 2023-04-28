//
//  MainOrderListViewModelTests.swift
//  OrderMateTests
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import XCTest
@testable import OrderMate

class MainOrderListViewModelTests: XCTestCase {
    
    var sut: MainOrderListViewModel!

    override func setUpWithError() throws {
        sut = MainOrderListViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_addOrder() {
        // Given
        let orderName = "Test Order"
        
        // When
        sut.addOrder(orderName: orderName)
        
        // Then
        XCTAssertEqual(sut.numberOfOrders, 1)
        XCTAssertEqual(sut.order(at: 0).name, orderName)
    }
    
    func test_maximumNumberOfOrders() {
        // Given
        
        for i in 1...10 {
            sut.addOrder(orderName: "\(i)")
        }
        
        // When
        sut.addOrder(orderName: "New order")
       
        // Then
        XCTAssertEqual(sut.numberOfOrders,10)
    }

    
    func test_searchOrders() {
         // Given
         let orderName1 = "Order 1"
         let orderName2 = "Order 2"
        sut.addOrder(orderName: orderName1)
        sut.addOrder(orderName: orderName2)
         
         // When
         sut.searchOrders(text: "Order 1")
         
         // Then
         XCTAssertEqual(sut.numberOfOrders, 1)
         XCTAssertEqual(sut.order(at: 0).name, orderName1)
         
         // When
         sut.searchOrders(text: "3")
         
         // Then
         XCTAssertEqual(sut.numberOfOrders, 0)
     }
    
    func testUpdateOrderStatus() {
        // Given
        sut.addOrder(orderName: "Burger")
        
        // When
        sut.updateOrderStatus(at: 0)
        
        // Then
        XCTAssertEqual(sut.order(at: 0).status, .preparing)
        sut.updateOrderStatus(at: 0)
        XCTAssertEqual(sut.order(at: 0).status, .ready)
        sut.updateOrderStatus(at: 0)
        XCTAssertEqual(sut.order(at: 0).status, .delivered)
    }
    
}

