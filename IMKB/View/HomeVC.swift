//
//  HomeVC.swift
//  IMKB
//
//  Created by Yunus Tek on 17.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, XMLParserDelegate {

    var parser = XMLParser()
    var data = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func btnGet(_ sender: Any) {
        parser = XMLParser(contentsOf: URL(string: "http://mobileexam.veripark.com/mobileforeks/service.asmx")!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        print(elementName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
