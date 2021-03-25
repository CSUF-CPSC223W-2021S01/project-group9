//
//  Justin.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/2/21.
//

import Foundation

class data{
    var transactions = [transaction]()
    init(){
//        transactions.append(transaction(name:"", amount: 0, currency: "", date:""))
    }
    func addTransaction(transaction: transaction){
        transactions.append(transaction)
    }
    func total() -> Int{
        return self.transactions.count
    }
    func getTransaction(index: Int) -> transaction{
        return transactions[index]
    }
    func clear() {
        self.transactions =  [transaction]()
    }
}


struct transaction {
    var name: String
    var amount: Double
    var currency: String
    var date: String

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
