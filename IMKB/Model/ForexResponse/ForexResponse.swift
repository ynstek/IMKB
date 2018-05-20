//
//  ForexResponse.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation

struct ForexResponse {
    var stockandIndexes: [StockandIndexes] = []
    var imkb100: [ImkbVolume] = []
    var imkb50: [ImkbVolume] = []
    var imkb30: [ImkbVolume] = []
    var stockandIndexGraphic: [StockandIndexGraphic] = []
}
