//
//  Encrypt.swift
//  IMKB
//
//  Created by Yunus Tek on 18.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
import StringExtensionHTML
import AEXML

private let _sharedEncrypt = Encrypt()

class Encrypt: NSObject {
    
    class var shared : Encrypt {
        return _sharedEncrypt
    }

    class func getRequestIsValid(completion: @escaping (_ response: String) -> Void) {
        let soapRequest = AEXMLDocument()
        let envelopeAttributes = ["xmlns:xsi" : Service.Url.xsi.rawValue
            , "xmlns:xsd" : Service.Url.xsd.rawValue
            , "xmlns:soap" : Service.Url.envelope.rawValue
        ]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "soap:Body")
        let encryptAttributes = ["xmlns" : "http://tempuri.org/"]
        let encrypt = body.addChild(name: "Encrypt", attributes: encryptAttributes)
        let request = encrypt.addChild(name: "request")
        request.value = "RequestIsValid" + Date().todayDate()
       
        let soapLenth = String(soapRequest.xml.count)
        let theURL = URL(string: Service.Url.service.rawValue)
        
        var urlRequest = URLRequest(url: theURL!)
        urlRequest.addValue("mobileexam.veripark.com", forHTTPHeaderField: "Host")
        urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        urlRequest.addValue("http://tempuri.org/Encrypt", forHTTPHeaderField: "SOAPAction")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        
        Alamofire.request(urlRequest).responseString { response in
            if let xmlString = response.result.value {
                let xml = SWXMLHash.parse(xmlString)
                let body =  xml["soap:Envelope"]["soap:Body"]
                if let EncryptResultElement = body["EncryptResponse"]["EncryptResult"].element {
                    completion(EncryptResultElement.text)
                }
            } else{
                print("error fetching XML")
                AlertFunctions.messageType.showOKAlert("ERROR!", bodyMessage: "Error fetching XML")
            }
        }
    }
}
