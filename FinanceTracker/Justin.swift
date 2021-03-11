//
//  Justin.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/2/21.
//

import Foundation

struct transaction {
    var date_transacted: String
    var date_posted: String
    var amount: Double
    var description: String
    var currency: String

    init(date_transacted: String, date_posted: String, amount: Double, description: String, currency: String) {
        self.date_transacted = date_transacted
        self.date_posted = date_posted
        self.amount = amount
        self.description = description
        self.currency = currency
    }
}
