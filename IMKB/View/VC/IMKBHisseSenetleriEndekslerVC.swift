//
//  IMKBHisseSenetleriEndekslerVC.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit

class IMKBHisseSenetleriEndekslerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "high" {
            let view = segue.destination as! StockandIndexVC
            view.imkbType = .high
        } else if segue.identifier == "low" {
            let view = segue.destination as! StockandIndexVC
            view.imkbType = .low
        } else if segue.identifier == "all"  {
            let view = segue.destination as! StockandIndexVC
            view.imkbType = .all
        }
        
    }
    
    
}
