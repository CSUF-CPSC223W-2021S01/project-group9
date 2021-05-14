//
//  FinanceTrackerTests.swift
//  FinanceTrackerTests
//
//  Created by Monte  Davityan  on 2/23/21.
//

import XCTest
@testable import FinanceTracker

class FinanceTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testStructTranactionInit() throws{
        let test = transaction(name:"DogeCoin", amount: 200, currency: "USD", date: "05/01/21")
        XCTAssertEqual(test.name    , "DogeCoin", "name     does not match init value")
        XCTAssertEqual(test.amount  , 200       , "amount   does not match init value")
        XCTAssertEqual(test.currency, "USD"     , "currency does not match init value")
        XCTAssertEqual(test.date    , "05/01/21", "date     does not match init value")
    }
    func testClassDataInit() throws{
        let dataContainer = data()
        XCTAssertEqual(dataContainer.total(), 0, "Data class must be initialized with 0 transactions")
    }
    func testClassDataAdd() throws{
        let dataContainer = data()
        let transactionTest = transaction(name:"DogeCoin", amount: 200, currency: "USD", date: "05/01/21")
        dataContainer.addTransaction(transaction:transactionTest)
        
        let test = dataContainer.getTransaction(index: 0)
        XCTAssertEqual(test.name    , "DogeCoin", "name     does not match init value")
        XCTAssertEqual(test.amount  , 200       , "amount   does not match init value")
        XCTAssertEqual(test.currency, "USD"     , "currency does not match init value")
        XCTAssertEqual(test.date    , "05/01/21", "date     does not match init value")
    }
    func testClassDataClear() throws{
        let dataContainer = data()
        let transactionTest = transaction(name:"DogeCoin", amount: 200, currency: "USD", date: "05/01/21")
        dataContainer.addTransaction(transaction:transactionTest)
        
        dataContainer.clear()
        XCTAssertEqual(dataContainer.total(), 0, "Data class must have 0 transactions when using clear")
    }
    func testClassDataTotal() throws{
        let dataContainer = data()
        let transactionTest = transaction(name:"DogeCoin", amount: 200, currency: "USD", date: "05/01/21")
        dataContainer.addTransaction(transaction:transactionTest)
        dataContainer.addTransaction(transaction:transactionTest)
        dataContainer.addTransaction(transaction:transactionTest)
        
        XCTAssertEqual(dataContainer.total(), 3, "Data class does not have correct total")
    }
}
