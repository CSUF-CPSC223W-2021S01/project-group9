//
//  DataController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

// used to convert a rgb value or hex value to a UIColor value
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class DataController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dataContainer = data()
    @IBOutlet var table: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        table?.delegate = self
        table?.dataSource = self
        // creates a listener so other view controllers can update the table
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    // sets the number of prototype cells needed in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataContainer.total()
    }
    // creates prototype cells based on the number of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.dateLabel!.text = self.dataContainer.getTransaction(index: indexPath.row).date
        cell.merchantNameLabel!.text = self.dataContainer.getTransaction(index: indexPath.row).name
        let amount = self.dataContainer.getTransaction(index: indexPath.row).amount
        // if amount is positive set the color to green
        // else set it to red
        if amount >= 0 {
            cell.amountLabel!.text = "$\(amount)"
            cell.amountLabel.textColor = UIColor(rgb: 0x1FFF33)
        }
        else {
            var amountString = String(amount)
            amountString.remove(at: amountString.startIndex)
            cell.amountLabel!.text = "-$" + amountString
            cell.amountLabel.textColor = UIColor.red
        }
        return cell
    }
    // button funtion to refresh table
    @IBAction func refreshButton(_ sender: Any) {
        self.updateTable()
    }
    // updates table based on the data from the saved plist
    @objc func updateTable(){
        let propertListDecoder = PropertyListDecoder()
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveUrl = directory.appendingPathComponent("transactions").appendingPathExtension("plist")
        
        if let retrievedTransactions = try? Data(contentsOf: archiveUrl),
           let decodedTransactions = try? propertListDecoder.decode(data.self, from: retrievedTransactions) {
            print(decodedTransactions.total())
            self.dataContainer = decodedTransactions
        }
        self.table?.reloadData()
    }
    // clears the table and data from the plist 
    @IBAction func clearButton(_ sender: Any) {
        self.dataContainer.clear()
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveUrl = directory.appendingPathComponent("transactions").appendingPathExtension("plist")

        let propertyListEncoder = PropertyListEncoder()
        if let encodedTransactions = try? propertyListEncoder.encode(self.dataContainer) {
            try? encodedTransactions.write(to: archiveUrl, options: .noFileProtection)
        }
        self.updateTable()
    }
}
