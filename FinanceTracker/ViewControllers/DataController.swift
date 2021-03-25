//
//  DataController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//

import UIKit

class DataController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeController().dataContainer.total()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
//        cell.dateLabel.text = "01-30-201\(indexPath.row)"
//        cell.merchantNameLabel.text = "Chase Bank"
//        cell.amountLabel.text = "$500"
        cell.dateLabel!.text = HomeController().dataContainer.getTransaction(index: indexPath.row).date
        cell.merchantNameLabel!.text = HomeController().dataContainer.getTransaction(index: indexPath.row).name
        cell.amountLabel!.text = String(HomeController().dataContainer.getTransaction(index: indexPath.row).amount)
        return cell
    }
    func updateTable(){
        UITableViewDataSource.reloadData()
    }
}
