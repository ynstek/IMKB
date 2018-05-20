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
        let view = segue.destination as! StockandIndexVC

        if segue.identifier == "high" {
            view.imkbType = .high
        } else if segue.identifier == "low" {
            view.imkbType = .low
        } else if segue.identifier == "all"  {
            view.imkbType = .all
        } else if segue.identifier == "imkb30" {
            view.imkbType = .imkb30
        } else if segue.identifier == "imkb50" {
            view.imkbType = .imkb50
        } else if segue.identifier == "imkb100" {
            view.imkbType = .imkb100
        }
    }
    
    
}
