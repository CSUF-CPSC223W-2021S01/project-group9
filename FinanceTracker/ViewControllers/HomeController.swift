//
//  HomeController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var dataContainer = data()
    @IBAction func getTransactions(_ sender: Any) {
        let transactions = FinanceTracker.getTransactions()
        transactions.requestData { result in
            print(result)
            let transactionArray = result["transactions"] as! [[String:Any]]
            for eachTransaction in transactionArray{
                let t = transaction(name:     eachTransaction["name"] as! String,
                                    amount:   eachTransaction["amount"] as! Double,
                                    currency: eachTransaction["iso_currency_code"] as! String,
                                    date:     eachTransaction["date"] as! String)
                self.dataContainer.addTransaction(transaction: t)
            }
        }
        DataController().updateTable()
    }
}
