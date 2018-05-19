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
}

struct StockandIndexes {
    var Symbol: String?
    var Price: Double?
    var Difference: Double?
    var Volume: Double?
    var Buying: Double?
    var Selling: Double?
    var Hour: String? 
    
    var DayPeakPrice: Double?
    var DayLowestPrice: Double?
    var Total: Int?
    var IsIndex: Bool
}
