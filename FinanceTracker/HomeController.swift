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
    @IBAction func getTransactions(_ sender: Any) {
        let transactions = FinanceTracker.getTransactions()
        transactions.requestData { result in
            print(result)
        }
    }

}
