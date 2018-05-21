//
//  StockandIndexVC+TableView.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation
import UIKit

extension StockandIndexVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StockandIndexTVCell
        
        let data = isFilter ? filteredStockandIndexesList[indexPath.row] : SoapImkbStockIndexList.shared.list[indexPath.row]
        
        cell.Symbol.text = data.symbol! + "\n" + String(data.selling!)
        cell.Price.text = String(data.price!) + " TL"
        
        let difference = data.difference!
        cell.Difference.text = "%" + String(difference)
        cell.DifferenceImage.image = difference > 0 ? UIImage(named: "up") : UIImage(named: "down")
        
        cell.Volume.text = String(data.volume!)
        cell.Buying.text = String(data.buying!)
        cell.Selling.text = String(data.selling!)
        
        let hour = data.hour!.dropLast(2)
        cell.Hour.text = String(hour.dropLast(2) + ":" + hour.dropFirst(2))

        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(hexString: "#EEEEEE")
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isFilter ? filteredStockandIndexesList.count : SoapImkbStockIndexList.shared.list.count
        return count
    }    
}


extension StockandIndexVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = isFilter ? filteredStockandIndexesList[indexPath.row] : SoapImkbStockIndexList.shared.list[indexPath.row]

        SoapImkbStockIndexList.shared.selected = selectedData
    }
    
}
