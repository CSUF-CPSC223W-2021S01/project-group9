//
//  Monte.swift
//  FinanceTracker
//
//  Created by Monte  Davityan  on 2/28/21.
//

import Foundation
import LinkKit

class AccessToken: Codable {
    var accessToken: String
    
    init() {
        self.accessToken = ""
    }
    
    func addToken(accessToken: String) {
        self.accessToken = accessToken
    }
}

enum ConnectionStatus {
    case Success
    case URLError
    case DataResponseError
    case ExitError
    case FailedError
    case DataReplyError
}

class ConnectBankAccount {
    let url = "http://Project9-env.eba-mmrdmfce.us-east-2.elasticbeanstalk.com/"
    
    var viewControllerRef: UIViewController
    
    var linkHandler: Handler?
    
    init(_ viewControllerRef: UIViewController) {
        self.viewControllerRef = viewControllerRef
    }
    
    func storeAccessToken(token: String) {
        let accessTok = AccessToken()
        accessTok.addToken(accessToken: token)
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveUrl = directory.appendingPathComponent("token").appendingPathExtension("plist")

        let propertyListEncoder = PropertyListEncoder()
        if let encodedTransactions = try? propertyListEncoder.encode(accessTok) {
            try? encodedTransactions.write(to: archiveUrl, options: .noFileProtection)
        }
    }
    
    func connect(result: @escaping (ConnectionStatus) -> Void) {
        let othUrl = self.url + "api/create_link_token/"
        guard let URL = URL(string: othUrl) else {
            result(ConnectionStatus.URLError)
            return
        }
        let body = "userId=" + "1234"
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let dataResponse = data, error == nil else {
                result(ConnectionStatus.DataResponseError)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let dictionary = jsonResponse as? [String: Any] {
                    if let linkToken = dictionary["link_token"] as? String {
                        var linkConfig = LinkTokenConfiguration(token: linkToken, onSuccess: { success in
                            let publicToken = success.publicToken
                            
                            let newUrl: String = self.url + "api/set_access_token/"
                            guard let URL2 = Foundation.URL(string: newUrl) else {
                                result(ConnectionStatus.URLError)
                                return
                            }
                            let body2 = "public_token=" + publicToken + "&" + body

                            var request2 = URLRequest(url: URL2)
                            request2.httpBody = body2.data(using: .utf8)
                            request2.httpMethod = "POST"
                            request2.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                            let task2 = URLSession.shared.dataTask(with: request2) { data, _, error in
                                guard let dataResponse2 = data, error == nil else {
                                    result(ConnectionStatus.DataResponseError)
                                    return
                                }
                                do {
                                    let jsonResponse2 = try JSONSerialization.jsonObject(with: dataResponse2, options: [])
                                    if let dictionary2 = jsonResponse2 as? [String: Any] {
                                        var status: String = ""
                                        if let status_ = dictionary2["Status:"] as? String {
                                            status = status_
                                        }
                                        if status == "Success" {
                                            let token = dictionary2["accessToken"]
                                            self.storeAccessToken(token: token as! String)
                                            result(ConnectionStatus.Success)
                                        } else {
                                            result(ConnectionStatus.DataReplyError)
                                        }
                                    }
                                } catch {
                                    result(ConnectionStatus.FailedError)
                                }
                            }
                            task2.resume()
                        })
                        linkConfig.onExit = { _ in
                            result(ConnectionStatus.ExitError)
                        }
                        let res = Plaid.create(linkConfig)
                        switch res {
                        case .failure(_):
                            result(ConnectionStatus.FailedError)
                        case .success(let handler):
                            DispatchQueue.main.async {
                                handler.open(presentUsing: .viewController(self.viewControllerRef))
                                self.linkHandler = handler
                            }
                        }
                    }
                }
            } catch {
                result(ConnectionStatus.FailedError)
            }
        }
        task.resume()
    }
}
