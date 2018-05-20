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

private let _sharedEncrypt = SoapEncrypt()

class SoapEncrypt: NSObject {
    
    class var shared : SoapEncrypt {
        return _sharedEncrypt
    }
    
    class func getRequestIsValid(completion: @escaping (_ response: String) -> Void) {
        if NetworkReachabilityManager()?.isReachable ?? false {
            
            let soapRequest = AEXMLDocument()
            let envelopeAttributes = ["xmlns:xsi" : Service.Url.xsi.rawValue
                , "xmlns:xsd" : Service.Url.xsd.rawValue
                , "xmlns:soap" : Service.Url.envelope.rawValue
            ]
            let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
            let body = envelope.addChild(name: "soap:Body")
            let encryptAttributes = ["xmlns" : Service.Url.tempuri.rawValue]
            let encrypt = body.addChild(name: "Encrypt", attributes: encryptAttributes)
            let request = encrypt.addChild(name: "request")
            
            request.value = "RequestIsValid" + Date().todayDate()
            
            let theURL = URL(string: Service.Url.service.rawValue)
            let action = "Encrypt"
            let urlRequest = Service.addValues(soapRequest, theURL: theURL!, SOAPaction: Service.Url.tempuri.rawValue + action)
            
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
        } else {
            AlertFunctions.messageType.showOKAlert("Bir ağa bağlı değilsiniz!", bodyMessage: "Lütfen ağ bağlantınızı kontrol edip tekrar deneyiniz.")
        }
    }
    
}
