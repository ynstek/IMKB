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
        
        var dataEntries: [BarChartDataEntry] = []
        var count = 0
        for i in dataPoints {
            let dateEntry = BarChartDataEntry(x: Double(i)!, y: values[count])
            dataEntries.append(dateEntry)
            count += 1
        }
        
        let xAxis = barChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        
        barChartView.pinchZoomEnabled = true
        barChartView.chartDescription?.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = true
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        var year = ""
        if SoapImkbStockIndexDetail.shared.list.count != 0 {
            year = SoapImkbStockIndexDetail.shared.list[0].date!.ToYear() + " yılı"
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: year)
        chartDataSet.resetColors()
        chartDataSet.drawValuesEnabled = true
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
    }
}
