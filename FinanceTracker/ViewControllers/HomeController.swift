//
//  HomeController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class HomeController: UIViewController {
    var dataContainer = data()
    
    @IBOutlet weak var displayLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLbl.text = "Transactions"
    }
    
    // Gets the data from an account and save it into a plist file
    @IBAction func getTransactions(_ sender: Any) {
        self.dataContainer.clear()
        // Gets data and stores it in dataContainer
        let transactions = FinanceTracker.getTransactions()
        transactions.requestData { result in
            let transactionArray = result["transactions"] as! [[String:Any]]
            for eachTransaction in transactionArray{
                let t = transaction(name:     eachTransaction["name"] as! String,
                                    amount:   eachTransaction["amount"] as! Double,
                                    currency: eachTransaction["iso_currency_code"] as! String,
                                    date:     eachTransaction["date"] as! String)
                self.dataContainer.addTransaction(transaction: t)
            }
            // Waits 3 seconds before saving the data into a plist file
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let archiveUrl = directory.appendingPathComponent("transactions").appendingPathExtension("plist")

                let propertyListEncoder = PropertyListEncoder()
                if let encodedTransactions = try? propertyListEncoder.encode(self.dataContainer) {
                    try? encodedTransactions.write(to: archiveUrl, options: .noFileProtection)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
        } onFailure: {
            print("Error. Failure when getting transactions")
        }
        
    }
    // returns the number of transactions
    @IBAction func getTotalTransactions(_ sender: Any) {
        print(self.dataContainer.total())
    }
}
