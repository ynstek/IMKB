//
//  Service.swift
//  IMKB
//
//  Created by Yunus Tek on 18.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation
import AEXML

class Service: NSObject {
    
    enum Period: String {
        case month = "Month"
        case week = "Week"
        case day = "Day"
    }
    
    enum Url: String {
        case service = "http://mobileexam.veripark.com/mobileforeks/service.asmx"
        case xsi = "http://www.w3.org/2001/XMLSchema-instance"
        case xsd = "http://www.w3.org/2001/XMLSchema"
        case tempuri = "http://tempuri.org/"
        case envelope = "http://schemas.xmlsoap.org/soap/envelope/"
    }
    
    class func addValues(_ soapRequest: AEXMLDocument, theURL: URL, SOAPaction: String) -> URLRequest {
        let soapLenth = String(soapRequest.xml.count)
        var urlRequest = URLRequest(url: theURL)
        urlRequest.addValue("mobileexam.veripark.com", forHTTPHeaderField: "Host")
        urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        urlRequest.addValue(SOAPaction, forHTTPHeaderField: "SOAPAction")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        
        return urlRequest
    }
    
    class func addChilds(_ soapRequest: AEXMLDocument, requestKey: String, period: Period, symbol: String? = nil) {

        let envelopeAttributes = ["xmlns:soapenv" : Service.Url.envelope.rawValue
            , "xmlns:tem"     : Service.Url.tempuri.rawValue
        ]
        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: envelopeAttributes)
        
        let pre = "tem:"
        let body = envelope.addChild(name: "soapenv:Body")
        let GetForexStocksandIndexesInfo = body.addChild(name: pre + "GetForexStocksandIndexesInfo")
        let request = GetForexStocksandIndexesInfo.addChild(name: pre + "request")
        
        request.addChild(name: pre + "IsIPAD").value = "true"
        request.addChild(name: pre + "DeviceID").value = "test"
        request.addChild(name: pre + "DeviceType").value = "ipad"
        request.addChild(name: pre + "RequestKey").value = requestKey
        request.addChild(name: pre + "Period").value = period.rawValue
        
        if symbol != nil {
            request.addChild(name: pre + "RequestedSymbol").value = symbol
        }        
    }
}

