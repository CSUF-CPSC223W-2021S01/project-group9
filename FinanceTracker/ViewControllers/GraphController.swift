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
        displayLbl.text = "Transactions Per Month"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // creates the bar graph
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center
        // centers the bar graph
        
        view.addSubview(barChart)
        // bar chart data values
        // bar chart for transactions per month
        self.getData()
        var jan = 0, feb = 0, mar = 0, apr = 0, may = 0, jun = 0, jul = 0, aug = 0, sep = 0, oct = 0, nov = 0, dec = 0
        
        let totalTranscations: Int = dataContainer.total()
        if totalTranscations  == 0{
            
        }
        else {
            for x in 0...(totalTranscations - 1) {
               var transcation = dataContainer.getTransaction(index: x)
                let date = transcation.date
                var temp1: Character = date[date.index(date.startIndex, offsetBy: 5)]
                var temp2: Character = date[date.index(date.startIndex, offsetBy: 6)]
                
                if (temp1 == "0" && temp2 == "1"){
                    jan += 1
                }
                else if (temp1 == "0" && temp2 == "2"){
                    feb += 1
                }
                else if (temp1 == "0"  && temp2 == "3"){
                    mar += 1
                }
                else if (temp1 == "0" && temp2 == "4"){
                    apr += 1
                }
                else if (temp1 == "0" && temp2 == "5"){
                    may += 1
                }
                else if (temp1 == "0" && temp2 == "6"){
                    jun += 1
                }
                else if (temp1 == "0" && temp2 == "7"){
                    jul += 1
                }
                else if (temp1 == "0" && temp2 == "8"){
                    aug += 1
                }
                else if (temp1 == "0" && temp2 == "9"){
                    sep += 1
                }
                else if (temp1 == "1" && temp2 == "0"){
                    oct += 1
                }
                else if (temp1 == "1" && temp2 == "1"){
                    nov += 1
                }
                else if (temp1 == "1" && temp2 == "2"){
                    dec += 1
                }
                else{
                    jan = 0; feb = 0; mar = 0; apr = 0; may = 0; jun = 0; jul = 0; aug = 0; sep = 0; oct = 0; nov = 0; dec = 0;
                }
            }
            
            var entries = [BarChartDataEntry]()
            entries.append(BarChartDataEntry(x: Double(1), y: Double(jan)))
            entries.append(BarChartDataEntry(x: Double(2), y: Double(feb)))
            entries.append(BarChartDataEntry(x: Double(3), y: Double(mar)))
            entries.append(BarChartDataEntry(x: Double(4), y: Double(apr)))
            entries.append(BarChartDataEntry(x: Double(5), y: Double(may)))
            entries.append(BarChartDataEntry(x: Double(6), y: Double(jun)))
            entries.append(BarChartDataEntry(x: Double(7), y: Double(jul)))
            entries.append(BarChartDataEntry(x: Double(8), y: Double(aug)))
            entries.append(BarChartDataEntry(x: Double(9), y: Double(sep)))
            entries.append(BarChartDataEntry(x: Double(10), y: Double(oct)))
            entries.append(BarChartDataEntry(x: Double(11), y: Double(nov)))
            entries.append(BarChartDataEntry(x: Double(12), y: Double(dec)))
            
            // graph for total finances per month
            
            let set = BarChartDataSet(entries: entries, label: "Transcations per month")
            
            set.colors = ChartColorTemplates.joyful()
            
            let data = BarChartData(dataSet: set)
            
             
            barChart.data = data
        }
        // retrieves the data from
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
       

