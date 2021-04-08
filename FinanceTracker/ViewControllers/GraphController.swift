//
//  GraphController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//  modified by Shiv Bhagat on 4/03/2021
import Charts
import UIKit

class GraphController: UIViewController, ChartViewDelegate {
    var barChart = BarChartView()
    var dataContainer = data()
    
    @IBOutlet weak var displayLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        displayLbl.text = "Test Bar Graph"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // creates the bar graph
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center // centers the bar graph
        
        view.addSubview(barChart)
        // bar chart data values
        self.getData()
        //var totalTranscations: Int = data.total()
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = BarChartDataSet(entries: entries, label: "Test Bar Graph")
        
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        
        
        barChart.data = data
    }
    // retrieves the data from 
    func getData(){
        let propertListDecoder = PropertyListDecoder()
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveUrl = directory.appendingPathComponent("transactions").appendingPathExtension("plist")
    
        if let retrievedTransactions = try? Data(contentsOf: archiveUrl),
           let decodedTransactions = try? propertListDecoder.decode(data.self, from: retrievedTransactions) {
            print(decodedTransactions.total())
            self.dataContainer = decodedTransactions
        }
    }
}
