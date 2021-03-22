//
//  ViewController.swift
//  FinanceTracker
//
//  Created by Monte  Davityan  on 2/23/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func connectAccount(_ sender: Any) {
        let connect = ConnectBankAccount(self)
        connect.connect()
    }
    
    @IBAction func getTransactions(_ sender: Any) {
        let transactions = FinanceTracker.getTransactions()
        transactions.requestData { result in
            print(result) 
        }
    }
}

