//
//  StockandIndexDetailVC.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit
import Charts

class StockandIndexDetailVC: UIViewController, ChartViewDelegate {
    
    @IBOutlet var baslik: UILabel!
    @IBOutlet var Symbol: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var Difference: UILabel!
    @IBOutlet var DifferenceImage: UIImageView!
    @IBOutlet var DayPeakPrice: UILabel!
    @IBOutlet var DayLowestPrice: UILabel!
    @IBOutlet var Volume: UILabel!
    @IBOutlet var Total: UILabel!
    
    // Chart
    @IBOutlet var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillDetail()
    }
    
    func fillDetail() {
        if let detail = SoapImkbStockIndexList.shared.selected {
            self.getGraphic(detail.Symbol!)
            baslik.text = detail.Symbol
            Symbol.text = detail.Symbol
            Price.text = String(detail.Price!)
            
            let difference = detail.Difference!
            Difference.text = String(difference)
            DifferenceImage.image = difference > 0 ? UIImage(named: "up") : UIImage(named: "down")

            
            DayPeakPrice.text = String(detail.DayPeakPrice!)
            DayLowestPrice.text = String(detail.DayLowestPrice!)
            Volume.text = String(detail.Volume!)
            Total.text = String(detail.Total!)
        }
    }
    
    func getGraphic(_ symbol: String) {
        SoapImkbStockIndexDetail.getList(symbol: symbol, period: .day) { (response) in
            SoapImkbStockIndexDetail.shared.list = response
            self.fillChart()
        }
    }
    
    func fillChart() {
        self.lineChartView.delegate = self
//        self.lineChartView.chartDescription?.text = "Desc"
        self.lineChartView.noDataText = "Gösterilecek bir veri bulunamadı"
        
        self.setChartData()
    }
    
    func setChartData() {
        
        let values = (0..<20).map {
            (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(7) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
//        for i in dollars {
//            return ChartDataEntry(x: Double(i), y: val)
//        }
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
//        set1.drawIconsEnabled = false
        
//        set1.lineDashLengths = [5, 2.5]
//        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.red)
//        set1.setCircleColor(.yellow)
        set1.lineWidth = 4
//        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
//        set1.valueFont = .systemFont(ofSize: 9)
//        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 7
        set1.formSize = 15
        
//        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
//                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
//        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
//        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)

        let values2 = (0..<5).map {
            (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(2) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let set2 = LineChartDataSet(values: values2, label: "DataSet 2")
        set2.setColor(.green)

        let data = LineChartData(dataSets: [set1,set2])

        self.lineChartView.data = data

//        // 1 - creating an array of data entries
//        var dollar : [ChartDataEntry] = [ChartDataEntry]()
//        for i in dollars1 {
//            dollar.append(ChartDataEntry(x: Double(i), y: 8))
//        }
//
//        let set1: LineChartDataSet = LineChartDataSet(values: dollar, label: "Dollar")
//
//        var month : [ChartDataEntry] = [ChartDataEntry]()
//        for i in months {
//            month.append(ChartDataEntry(x: Double(i), y: 2))
//        }
//
//        let set2: LineChartDataSet = LineChartDataSet(values: month, label: "Month")
//
//
//        var dataSets = [LineChartDataSet]()
//        dataSets.append(set1)
//        dataSets.append(set2)
//
//        //4 - pass our months in for our x-axis label value along with our dataSets
////        let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
//        let data = LineChartData(dataSets: dataSets)
//        data.setValueTextColor(UIColor.white)
//
//        //5 - finally set our data
//        self.lineChartView.data = data
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}
