//
//  StockandIndexVC.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit

class StockandIndexVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getStockandIndex()
    }
    
    func getStockandIndex() {
        ImkbHisseIndexList.getList(completion: { (response) in
            ImkbHisseIndexList.shared.stockandIndexesList = response
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
