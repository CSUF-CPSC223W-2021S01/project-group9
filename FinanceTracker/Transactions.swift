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
    
    //TODO: make these dynamic to the device (ie, store this id)
    let tempAccessToken = "access-sandbox-19c042cd-833b-4d52-a962-d5bcf0044a48"
    
    let startDate = "2021-03-1"
    let endDate = "2021-03-03"
    
    func requestData(completion: @escaping ([String: Any]) -> ()) {
        
        let url = URL(string: self.transactionUrl)
        let payload = "{\"client_id\":\"\(self.clientId)\",\"secret\":\"\(self.secret)\",\"access_token\":\"\(self.tempAccessToken)\", \"start_date\":\"2018-01-01\", \"end_date\":\"2021-03-01\"}".data(using: .utf8)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data else {
                print("error")
                return
            }
            if let str = String(data: data, encoding: .utf8) {
                return completion(self.convertToDictionary(text: str) ?? [String: Any]())
            }
        }.resume()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
