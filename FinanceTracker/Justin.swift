//
//  Justin.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/2/21.
//

import Foundation

class data: Codable{
    var transactions = [transaction]()
    init(){
        self.transactions = [transaction]()
    }
    func addTransaction(transaction: transaction){
        self.transactions.append(transaction)
    }
    func total() -> Int{
        return self.transactions.count
    }
    func getTransaction(index: Int) -> transaction{
        return self.transactions[index]
    }
    func clear() {
        self.transactions =  [transaction]()
    }
}


struct transaction: Codable{
    let name: String
    let amount: Double
    let currency: String
    let date: String

    init(name: String,
         amount: Double,
         currency: String,
         date: String) {
        
        self.name            = name
        self.amount          = amount
        self.currency        = currency
        self.date            = date
        
    }
}
