//
//  Transactions.swift
//  FinanceTracker
//
//  Created by Monte  Davityan  on 3/2/21.
//

import Foundation


//curl -X POST https://sandbox.plaid.com/transactions/get -H 'Content-Type: application/json' -d '{"client_id":"602e9d8caaddb00010348259","secret":"d4bcd044d1751fba527799f724b043", "access_token":"access-sandbox-19c042cd-833b-4d52-a962-d5bcf0044a48", "start_date":"2018-01-01", "end_date":"2021-03-01"}'

class getTransactions {
    
    let transactionUrl = "https://sandbox.plaid.com/transactions/get"
    let clientId = "602e9d8caaddb00010348259"
    let secret = "d4bcd044d1751fba527799f724b043"
    
    let tempAccessToken = "access-sandbox-19c042cd-833b-4d52-a962-d5bcf0044a48"
    
    let startDate = "2020-10-10"
    let endDate = "2021-03-01"
    
    //TODO: POST request to get transactions data (see curl request above)
}
