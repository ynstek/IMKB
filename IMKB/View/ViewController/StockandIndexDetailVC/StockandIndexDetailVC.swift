//
//  StockandIndexDetailVC.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit
import Charts

class StockandIndexDetailVC: UIViewController {
    @IBOutlet var baslik: UILabel!
    @IBOutlet var Symbol: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var Difference: UILabel!
    @IBOutlet var DifferenceImage: UIImageView!
    @IBOutlet var DayPeakPrice: UILabel!
    @IBOutlet var DayLowestPrice: UILabel!
    @IBOutlet var Volume: UILabel!
    @IBOutlet var Total: UILabel!
    @IBOutlet var Last: UILabel!
    
    @IBOutlet var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillDetail()
    }
    
    func fillDetail() {
        if let detail = SoapImkbStockIndexList.shared.selected {
            self.getGraphic(detail.symbol!, period: .day)
            baslik.text = !detail.name!.isEmpty ? detail.name! : detail.symbol
            Symbol.text = detail.symbol
            Price.text = String(detail.price!)
            Last.text = String(detail.price!)
            
            let difference = detail.difference!
            Difference.text = String(difference)
            DifferenceImage.image = difference > 0 ? UIImage(named: "up") : UIImage(named: "down")
            
            DayPeakPrice.text = String(detail.dayPeakPrice!)
            DayLowestPrice.text = String(detail.dayLowestPrice!)
            Volume.text = String(detail.volume!)
            Total.text = String(detail.total!)
        }
    }
    
    @IBAction func SgmPeriodChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if let detail = SoapImkbStockIndexList.shared.selected {
                self.getGraphic(detail.symbol!, period: .day)
            }
        case 1:
            if let detail = SoapImkbStockIndexList.shared.selected {
                self.getGraphic(detail.symbol!, period: .week)
            }
        case 2:
            if let detail = SoapImkbStockIndexList.shared.selected {
                self.getGraphic(detail.symbol!, period: .month)
            }
        default: break
            //
        }
    }
    
    
    func getGraphic(_ symbol: String, period: Service.Period) {
        SoapImkbStockIndexDetail.getList(symbol: symbol, period: period) { (response) in
            SoapImkbStockIndexDetail.shared.list = response
            self.fillChart()
        }
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
