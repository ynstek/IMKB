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
    
    @IBOutlet var baslik: UILabel!
    
    var imkbType = ImkbType.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImkbHisseIndexList.shared.stockandIndexesList.removeAll()
        
        self.getStockandIndex()
    }
    
    func getStockandIndex() {
        self.setBaslik()
        ImkbHisseIndexList.getList(completion: { (response) in
            self.setData(response.StockandIndexes)
            self.tableView.reloadData()
        })
    }
    
    func setData(_ response: [StockandIndexes]) {
        switch self.imkbType {
        case .low:
            ImkbHisseIndexList.shared.stockandIndexesList = response.filter() {
                r in
                return (r.Difference! < 0.0)
            }
        case .high:
            ImkbHisseIndexList.shared.stockandIndexesList = response.filter() {
                r in
                return (r.Difference! > 0.0)
            }
        default:
            ImkbHisseIndexList.shared.stockandIndexesList = response
        }
    }
    
    func setBaslik() {
        switch self.imkbType {
        case .low:
            self.baslik.text = "IMKB Düşenler"
        case .high:
            self.baslik.text = "IMKB Yükselenler"
        default:
            self.baslik.text = "Hisse Senetleri ve Endeksler"
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
