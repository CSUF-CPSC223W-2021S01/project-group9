//
//  GraphController.swift
//  FinanceTracker
//
//  Created by Justin Lee on 3/22/21.
//  Modifed by Shiv Bhagat on 3/23/2021

import UIKit
import SwiftUICharts
import SwiftUI

struct GraphController: View {
    var body: some View{
        VStack{
            Spacer()
            // Line chart
            LineChartView(data: [12,22,6,1,2,7,18], title: "Test LineChart")
            Spacer()
             // Bar Chart
            BarChartView(data: ChartData(values:[("Jan", 12) , ("Feb", 2) , ("Mar", 3)]
            ) , title: "Test Bar Graph")
        }
    }
}

struct GraphController_previews: PreviewProvider {
    static var previews: some View {
        GraphController()
    }
}

