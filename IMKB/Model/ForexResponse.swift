//
//  ForexResponse.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation

struct ForexResponse {
    var StockandIndexes: [StockandIndexes] = []
    var Imkb100: [ImkbVolume] = []
    var Imkb50: [ImkbVolume] = []
    var Imkb30: [ImkbVolume] = []
}
