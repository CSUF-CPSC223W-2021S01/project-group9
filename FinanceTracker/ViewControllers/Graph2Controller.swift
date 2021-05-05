//
//  Graph2Controller.swift
//  FinanceTracker
//
//  Created by Shiv Bhagat on 4/16/21.
//

import UIKit
import Charts

class Graph2Controller: UIViewController, ChartViewDelegate {
    var barChart = BarChartView()
    var dataContainer = data()
    
 
    @IBOutlet weak var displaylbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        displaylbl.text = "Finances Per Month"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // creates the bar graph
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center // centers the bar graph
        
        view.addSubview(barChart)
        // bar chart data values
        // graph for total finances per month
        self.getData()
        var entries = [BarChartDataEntry]()
        var jan : Double = 0, feb: Double = 0, mar: Double = 0, apr: Double = 0, may: Double = 0, jun: Double = 0,
            jul: Double = 0, aug: Double = 0, sep: Double = 0, oct: Double = 0, nov: Double = 0, dec: Double = 0
        let totalTranscations: Int = dataContainer.total()
        if(totalTranscations == 0){
            displaylbl.text = "Connect account"
            
        }else{
            for x in 0...(totalTranscations - 1) {
               var transcation = dataContainer.getTransaction(index: x)
                let date = transcation.date
                let amount = transcation.amount
                var temp1: Character = date[date.index(date.startIndex, offsetBy: 5)]
                var temp2: Character = date[date.index(date.startIndex, offsetBy: 6)]
        
                if (temp1 == "0" && temp2 == "1"){
                    if(amount > 0){
                        jan += amount
                    }
                    else{
                        jan = jan + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "2"){
                    if(amount > 0){
                        feb += amount
                    }
                    else{
                        feb = feb + amount
                    }
                }
                else if (temp1 == "0"  && temp2 == "3"){
                    if(amount > 0){
                        mar += amount
                    }
                    else{
                        mar = mar + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "4"){
                    if(amount > 0){
                        apr += amount
                    }
                    else{
                        apr = apr + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "5"){
                    if(amount > 0){
                        may += amount
                    }
                    else{
                        may = may + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "6"){
                    if(amount > 0){
                        jun += amount
                    }
                    else{
                        jun = jun + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "7"){
                    if(amount > 0){
                        jul += amount
                    }
                    else{
                        jul = jul + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "8"){
                    if(amount > 0){
                        aug += amount
                    }
                    else{
                        aug = aug + amount
                    }
                }
                else if (temp1 == "0" && temp2 == "9"){
                    if(amount > 0){
                        sep += amount
                    }
                    else{
                        sep = sep + amount
                    }
                }
                else if (temp1 == "1" && temp2 == "0"){
                    if(amount > 0){
                        oct += amount
                    }
                    else{
                        oct = oct + amount
                    }
                }
                else if (temp1 == "1" && temp2 == "1"){
                    if(amount > 0){
                        nov += amount
                    }
                    else{
                        nov = nov + amount
                    }
                }
                else if (temp1 == "1" && temp2 == "2"){
                    if(amount > 0){
                        dec += amount
                    }
                    else{
                        dec = dec + amount
                    }
                }
                else{
                    jan = 0; feb = 0; mar = 0; apr = 0; may = 0; jun = 0; jul = 0; aug = 0; sep = 0; oct = 0; nov = 0; dec = 0;
                }
                
            }
            
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
            
        }
        
        let set = BarChartDataSet(entries: entries, label: "Finances per month")
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
