//
//  Justin.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/2/21.
//

import Foundation

struct transaction {
    var name             : String
    var account_owner    : String
    var amount           : Double
    var authorized_date  : String
    var currency         : String
    var date             : String
    

    init(name             : String,
         account_owner    : String,
         amount           : Double,
         authorized_date  : String,
         currency         : String,
         date             : String) {
        
        self.name            = name
        self.account_owner   = account_owner
        self.amount          = amount
        self.authorized_date = authorized_date
        self.currency        = currency
        self.date            = date
        
    }
}
