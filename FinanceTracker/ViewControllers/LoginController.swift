//
//  LoginController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var displayLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLbl.text = "Login"

    }
    @IBAction func connectAccount(_ sender: Any) {
        let connect = ConnectBankAccount(self)
        connect.connect() { result in
            switch result {
            case .Success:
                print("Success")
            case .DataReplyError:
                print("Data Reply Error")
            case .DataResponseError:
                print("Data Response Error")
            case .ExitError:
                print("User Exited Error")
            case .FailedError:
                print("Failed Error")
            case .URLError:
                print("URL Errors")
            }
        }
    }
    @IBAction func nextSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "tabBarController", sender: self)
    }
    
}
