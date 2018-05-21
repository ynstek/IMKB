//
//  StockandIndexVC.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit
import Alamofire

class StockandIndexVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var baslik: UILabel!
    @IBOutlet var searchBar: UISearchBar!

    var imkbType = ImkbType.all
    
    // Filter
    var isFilter = false
    lazy var filteredStockandIndexesList: [StockandIndexes] = {
        return [StockandIndexes]()
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshControlData), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func refreshControlData() {
        self.getStockandIndex()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SoapImkbStockIndexList.shared.list.removeAll()
        self.getStockandIndex()
        tableView.insertSubview(self.refreshControl, at: 0)
    }
    
    func getStockandIndex() {
        self.setBaslik()
            SoapImkbStockIndexList.getList(period: .day, completion: { (response) in
                self.setData(response)
                self.tableView.reloadData()
                DispatchQueue.main.async() {
                    self.refreshControl.endRefreshing()
                }
            })
    
    }
    
    func getNowTime() -> String {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "d MMM HH:mm:ss" // "d MMM HH:mm:ss.SSSZZZZZ"
        
        return formatter.string(from: date)
    }
    
    func setData(_ response: ForexResponse) {
        switch self.imkbType {
        case .low:
            SoapImkbStockIndexList.shared.list = response.stockandIndexes.filter() { r in
                return (r.difference! < 0.0)
            }
        case .high:
            SoapImkbStockIndexList.shared.list = response.stockandIndexes.filter() { r in
                return (r.difference! > 0.0)
            }
        case .imkb30:
            for imkb in response.imkb30 {
                var stock = response.stockandIndexes.filter() {
                    stock in
                    return stock.symbol! == imkb.symbol!
                }
                if stock.count != 0 {
                    stock[0].name = imkb.name
                    SoapImkbStockIndexList.shared.list.append(stock[0])
                }
            }
        case .imkb50:
            for imkb in response.imkb50 {
                var stock = response.stockandIndexes.filter() {
                    stock in
                    return stock.symbol! == imkb.symbol!
                }
                if stock.count != 0 {
                    stock[0].name = imkb.name
                    SoapImkbStockIndexList.shared.list.append(stock[0])
                }
            }
        case .imkb100:
            for imkb in response.imkb100 {
                var stock = response.stockandIndexes.filter() {
                    stock in
                    return stock.symbol! == imkb.symbol!
                }
                if stock.count != 0 {
                    stock[0].name = imkb.name
                    SoapImkbStockIndexList.shared.list.append(stock[0])
                }
            }
        default: // all
            SoapImkbStockIndexList.shared.list = response.stockandIndexes
        }
    }
    
    func setBaslik() {
        switch self.imkbType {
        case .low:
            self.baslik.text = "IMKB Düşenler"
        case .high:
            self.baslik.text = "IMKB Yükselenler"
        case .imkb30:
            self.baslik.text = "IMKB Hacme Göre 30"
        case .imkb50:
            self.baslik.text = "IMKB Hacme Göre 50"
        case .imkb100:
            self.baslik.text = "IMKB Hacme Göre 100"
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
