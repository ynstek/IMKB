//
//  StockandIndexVC+Search.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation
import UIKit

extension StockandIndexVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text!.isEmpty {
            self.isFilter = false
        } else {
            self.isFilter = true
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            self.view.endEditing(true)
            self.isFilter = false
        } else {
            self.isFilter = true
            filteredStockandIndexesList.removeAll()
            var itemRange: NSRange
            var tmp: NSString
            for item in SoapImkbStockIndexList.shared.list {
                tmp = item.symbol! as NSString
                itemRange = tmp.range(of: searchBar.text! , options: NSString.CompareOptions.caseInsensitive)
                if itemRange.location != NSNotFound {
                    filteredStockandIndexesList.append(item)
                } else {
                    tmp = item.name! as NSString
                    itemRange = tmp.range(of: searchBar.text! , options: NSString.CompareOptions.caseInsensitive)
                    if itemRange.location != NSNotFound {
                        filteredStockandIndexesList.append(item)
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
}
