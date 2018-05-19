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
        let data = ImkbHisseIndexList.shared.stockandIndexesList[indexPath.row]
        
        cell.Symbol.text = data.Symbol
        cell.Price.text = String(data.Price!) + " TL"
        cell.Difference.text = "%" + String(data.Difference!)
        cell.Volume.text = String(data.Volume!)
        cell.Buying.text = String(data.Buying!)
        cell.Selling.text = String(data.Selling!)
        
        let hour = data.Hour!.dropLast(2)
        cell.Hour.text = String(hour.dropLast(2) + ":" + hour.dropFirst(2))

        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(hexString: "#EEEEEE")
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImkbHisseIndexList.shared.stockandIndexesList.count
    }    
}


extension StockandIndexVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
