//
//  HomeController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class HomeController: UIViewController {
    var dataContainer = data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getTransactions(_ sender: Any) {
        self.dataContainer.clear()
        let transactions = FinanceTracker.getTransactions()
        transactions.requestData { result in
            let transactionArray = result["transactions"] as! [[String:Any]]
            for eachTransaction in transactionArray{
                let t = transaction(name:     eachTransaction["name"] as! String,
                                    amount:   eachTransaction["amount"] as! Double,
                                    currency: eachTransaction["iso_currency_code"] as! String,
                                    date:     eachTransaction["date"] as! String)
                self.dataContainer.addTransaction(transaction: t)
//                print(self.dataContainer.total())
            }
        }
        
//        print(self.dataContainer.total())
    }
    @IBAction func exportData(_ sender: Any) {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveUrl = directory.appendingPathComponent("transactions").appendingPathExtension("plist")

        let propertyListEncoder = PropertyListEncoder()
        if let encodedTransactions = try? propertyListEncoder.encode(dataContainer) {
            try? encodedTransactions.write(to: archiveUrl, options: .noFileProtection)
        }
        print(self.dataContainer.total())
    }
    @IBAction func getTotalTransactions(_ sender: Any) {
        print(self.dataContainer.total())
    }
}
