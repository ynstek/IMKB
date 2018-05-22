//
//  StockandIndexDetailVC+Chart.swift
//  IMKB
//
//  Created by Yunus Tek on 21.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation
import Charts


extension StockandIndexDetailVC: ChartViewDelegate {
    func fillChart() {
        var prices = [Double]()
        var date = [String]()
        for i in SoapImkbStockIndexDetail.shared.list {
            prices.append(i.price!)
            date.append(String(i.date!.ToMonth()))
        }
        
        self.setChart(dataPoints: date, values: prices)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        let details = values
        guard details.count > 0 else { return }
        
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<details.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(details[i]))
            dataEntries.append(dataEntry)
        }
        
        let dataSet = LineChartDataSet(values: dataEntries, label: "Fiyat")
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        
        //        dataSet.highlightColor = .blue
        dataSet.drawFilledEnabled = true
        
        if Double(Difference.text!)! > 0.0 {
            dataSet.colors = [.green]
            dataSet.fillColor = .green
        } else {
            dataSet.colors = [.red]
            dataSet.fillColor = .red
        }
        
        let chartData = LineChartData(dataSet: dataSet)
        chartView.data = chartData
        
        chartView.scaleYEnabled = false
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.rightAxis.gridColor = .darkGray
        chartView.xAxis.labelPosition = .bottom
        
        var year = ""
        if SoapImkbStockIndexDetail.shared.list.count != 0 {
            year = SoapImkbStockIndexDetail.shared.list[0].date!.ToYear() + " yılı"
        }
        chartView.chartDescription?.text = year
        chartView.noDataFont = UIFont.boldSystemFont(ofSize: 18)
        chartView.backgroundColor = UIColor.clear
    }
}
