//
//  StocknIndexesResponseList.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation

enum ImkbType {
    case all
    case high
    case low
    case imkb30
    case imkb50
    case imkb100
}

struct StockandIndexes {
    var symbol: String?
    var price: Double?
    var difference: Double?
    var volume: Double?
    var buying: Double?
    var selling: Double?
    var hour: String? 
    
    var dayPeakPrice: Double?
    var dayLowestPrice: Double?
    var total: Int?
    var isIndex: Bool
    
    var name: String?
}
