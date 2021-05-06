//
//  LoginController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet var ConnectAccButton: UIButton!
    @IBOutlet weak var displayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLbl.text = "Login"
        ConnectAccButton.layer.cornerRadius = 10
        ConnectAccButton.clipsToBounds = true
    }
    @IBAction func connectAccount(_ sender: Any) {
        let connect = ConnectBankAccount(self)
        connect.connect() { result in
            switch result {
            case .Success:
                print("Success")
                DispatchQueue.main.async {
                    self.nextSegue()
                }
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
    func nextSegue() {
        self.performSegue(withIdentifier: "tabBarController", sender: self)
    }
    
}
