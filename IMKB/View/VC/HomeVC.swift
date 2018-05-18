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
    
//    var tableData = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getEncryptResult { (response) in
            print(response)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getEncryptResult(completion: @escaping (_ response: String) -> Void) -> Void {
        
        let soapRequest = AEXMLDocument()
        let envelopeAttributes = ["xmlns:xsi" : "http://www.w3.org/2001/XMLSchema-instance"
            , "xmlns:xsd" : "http://www.w3.org/2001/XMLSchema"
            , "xmlns:soap" : "http://schemas.xmlsoap.org/soap/envelope/"
        ]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "soap:Body")
        let encryptAttributes = ["xmlns" : "http://tempuri.org/"]
        let encrypt = body.addChild(name: "Encrypt", attributes: encryptAttributes)
        let request = encrypt.addChild(name: "request")
        request.value = "RequestIsValid" + getTodayDate()
        
        let soapLenth = String(soapRequest.xml.count)
        let theURL = URL(string: "http://mobileexam.veripark.com/mobileforeks/service.asmx")
        
        var mutableR = URLRequest(url: theURL!)
        mutableR.addValue("mobileexam.veripark.com", forHTTPHeaderField: "Host")
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.addValue("http://tempuri.org/Encrypt", forHTTPHeaderField: "SOAPAction")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        
        Alamofire.request(mutableR)
            .responseString { response in
                print("Response", response)
                if let xmlString = response.result.value {
                    let xml = SWXMLHash.parse(xmlString)
                    let body =  xml["soap:Envelope"]["soap:Body"]
                    if let EncryptResultElement = body["EncryptResponse"]["EncryptResult"].element {
                        completion(EncryptResultElement.text)
//                        let xmlInner = SWXMLHash.parse(getCountriesResult.stringByDecodingHTMLEntities)
//
//                        for element in xmlInner["NewDataSet"]["Table"].all {
//                            if let nameElement = element["Name"].element {
//                                var countryStruct = Country()
//                                countryStruct.name = nameElement.text
//                                result.append(countryStruct)
//                            }
//                        }
                    }
                }else{
                    print("error fetching XML")
                }
        }
    }
    
    func getTodayDate() -> String {
        let dateTime = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd:MM:yyyy HH:mm"
        //        return formatter.date(from: currentDate)! as Date
        return formatter.string(from: dateTime)
    }


}
