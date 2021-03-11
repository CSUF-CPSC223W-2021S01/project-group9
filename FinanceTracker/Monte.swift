//
//  Monte.swift
//  FinanceTracker
//
//  Created by Monte  Davityan  on 2/28/21.
//

import Foundation
import LinkKit


class ConnectBankAccount {
    let url = "http://Project9-env.eba-mmrdmfce.us-east-2.elasticbeanstalk.com/"
    
    var viewControllerRef: UIViewController
    
    var linkHandler: Handler?
    
    init(_ viewControllerRef: UIViewController) {
        self.viewControllerRef = viewControllerRef
    }
    
    func connect() {
        let othUrl = self.url + "api/create_link_token/"
        guard let URL = URL(string: othUrl) else { return }

          
        let body = "userId=" + "1234"

        do {
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            request.httpBody = body.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let dataResponse = data, error == nil else { return }
             
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                    if let dictionary = jsonResponse as? [String: Any] {
                        if let linkToken = dictionary["link_token"] as? String {
                            var linkConfig = LinkTokenConfiguration(token: linkToken, onSuccess: { success in
                            
                                let publicToken = success.publicToken
                                let accountId = success.metadata.accounts[0].id

                                let newUrl: String = self.url + "api/set_access_token/"
                                guard let URL2 = Foundation.URL(string: newUrl) else { return }
                                let body2 = "public_token=" + publicToken + "&" + body
                                do {
                                    var request2 = URLRequest(url: URL2)
                                    request2.httpBody = body2.data(using: .utf8)
                                    request2.httpMethod = "POST"
                                    request2.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                                    let task2 =  URLSession.shared.dataTask(with: request2) { (data, response, error) in
                                        guard let dataResponse2 = data,
                                              error == nil else { return }
                                        do {
                                            let jsonResponse2 = try JSONSerialization.jsonObject(with: dataResponse2, options: [])
                                            if let dictionary2 = jsonResponse2 as? [String: Any] {
                                                var status: String = ""
                                                if let status_ = dictionary2["Status:"] as? String {
                                                    status = status_
                                                }
                                                print(dictionary2)
                                                if status == "Success" {
                                                    print("success")
                                                    //TODO: store the "accessToken" in dictionary2 into a database
                                                }
                                                else {
                                                    print("errorer32")
                                                }
                                            }
                                        } catch {
                                            
                                        }
                                    }
                                    task2.resume()
                                } catch {
                                    print("error24243")
                                }
                                
                            })
                            linkConfig.onExit = { exit in
                                print("error")
                            }
                            let result = Plaid.create(linkConfig)
                                switch result {
                                case .failure(let error):
                                    print("failed")
                                case .success(let handler):
                                    DispatchQueue.main.async {
                                        handler.open(presentUsing: .viewController(self.viewControllerRef))
                                        self.linkHandler = handler
                                    }
                                }
                        }
                    }
                }
                catch {
                    print("error2")
                }
            }
            task.resume()
        } catch {
            print("error1")
        }
    }
}
