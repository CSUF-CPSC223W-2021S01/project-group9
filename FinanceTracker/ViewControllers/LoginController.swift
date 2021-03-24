//
//  LoginController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func connectAccount(_ sender: Any) {
        let connect = ConnectBankAccount(self)
        connect.connect()
    }

}
