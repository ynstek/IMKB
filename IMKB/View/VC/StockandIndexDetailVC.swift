//
//  StockandIndexDetailVC.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit

class StockandIndexDetailVC: UIViewController {
    
    @IBOutlet var baslik: UILabel!
    @IBOutlet var Symbol: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var Difference: UILabel!
    @IBOutlet var DayPeakPrice: UILabel!
    @IBOutlet var DayLowestPrice: UILabel!
    @IBOutlet var Volume: UILabel!
    @IBOutlet var Total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillDetail()
    }

    func fillDetail() {
        if let detail = ImkbHisseIndexList.shared.selectedStockandIndex {
            baslik.text = detail.Symbol
            Symbol.text = detail.Symbol
            Price.text = String(detail.Price!)
            Difference.text = String(detail.Difference!)
            DayPeakPrice.text = String(detail.DayPeakPrice!)
            DayLowestPrice.text = String(detail.DayLowestPrice!)
            Volume.text = String(detail.Volume!)
            Total.text = String(detail.Total!)
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
