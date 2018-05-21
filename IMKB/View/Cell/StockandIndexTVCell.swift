//
//  StockandIndexTVCell.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit

class StockandIndexTVCell: UITableViewCell {

    @IBOutlet var Symbol: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var Difference: UILabel!
    @IBOutlet var Volume: UILabel!
    @IBOutlet var Buying: UILabel!
    @IBOutlet var Selling: UILabel!
    @IBOutlet var Hour: UILabel!
    
    @IBOutlet var DifferenceImage: UIImageView!
}
