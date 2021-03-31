//
//  DataController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class DataController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dataContainer = data()
    
    @IBOutlet var table: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        table?.delegate = self
        table?.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataContainer.total()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
//        cell.dateLabel.text = "01-30-201\(indexPath.row)"
//        cell.merchantNameLabel.text = "Chase Bank"
//        cell.amountLabel.text = "$500"
        cell.dateLabel!.text = self.dataContainer.getTransaction(index: indexPath.row).date
        cell.merchantNameLabel!.text = self.dataContainer.getTransaction(index: indexPath.row).name
        cell.amountLabel!.text = String(self.dataContainer.getTransaction(index: indexPath.row).amount)
        return cell
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        let propertListDecoder = PropertyListDecoder()
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveUrl = directory.appendingPathComponent("transactions").appendingPathExtension("plist")
        
        if let retrievedTransactions = try? Data(contentsOf: archiveUrl),
           let decodedTransactions = try? propertListDecoder.decode(data.self, from: retrievedTransactions) {
            print(decodedTransactions.total())
            dataContainer = decodedTransactions
        }
        
        self.table?.reloadData()
        print(dataContainer.total())
    }
    
}
