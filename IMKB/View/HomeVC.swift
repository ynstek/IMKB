//
//  HomeVC.swift
//  IMKB
//
//  Created by Yunus Tek on 17.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import StringExtensionHTML
import AEXML

struct Country {
    var name:String = ""
}

class HomeVC: UIViewController, XMLParserDelegate {
    
    var tableData = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCountries { (result) in
            print(result)
            self.tableData = result
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCountries(completion: @escaping (_ result: [Country]) -> Void) -> Void {
        
        var result = [Country]()
        let soapRequest = AEXMLDocument()
        let envelopeAttributes = ["xmlns:SOAP-ENV" : "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns1" : "http://www.webserviceX.NET"]
        let envelope = soapRequest.addChild(name: "SOAP-ENV:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "SOAP-ENV:Body")
        body.addChild(name: "ns1:GetCountries")
        
        let soapLenth = String(soapRequest.xml.count)
        let theURL = URL(string: "http://www.webservicex.net/country.asmx")
        
        var mutableR = URLRequest(url: theURL!)
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        
        Alamofire.request(mutableR)
            .responseString { response in
                if let xmlString = response.result.value {
                    let xml = SWXMLHash.parse(xmlString)
                    let body =  xml["soap:Envelope"]["soap:Body"]
                    if let countriesElement = body["GetCountriesResponse"]["GetCountriesResult"].element {
                        let getCountriesResult = countriesElement.text
                        let xmlInner = SWXMLHash.parse(getCountriesResult.stringByDecodingHTMLEntities)
                        for element in xmlInner["NewDataSet"]["Table"].all {
                            if let nameElement = element["Name"].element {
                                var countryStruct = Country()
                                countryStruct.name = nameElement.text
                                result.append(countryStruct)
                            }
                        }
                    }
                    completion(result)
                }else{
                    print("error fetching XML")
                }
        }
    }


}
