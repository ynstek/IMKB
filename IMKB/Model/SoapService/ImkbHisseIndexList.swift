//
//  ImkbHisseIndexList.swift
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

private let _sharedImkbHisseIndexList = ImkbHisseIndexList()

class ImkbHisseIndexList: NSObject {
    
    class var shared : ImkbHisseIndexList {
        return _sharedImkbHisseIndexList
    }
    
    lazy var stockandIndexesList: [StockandIndexes] = {
        return [StockandIndexes]()
    }()
    
    
    class func getList(completion: @escaping (_ response: [StockandIndexes]) -> Void) {
        Encrypt.getRequestIsValid { (requestKey) in
            let soapRequest = AEXMLDocument()
            let envelopeAttributes = ["xmlns:soapenv" : Service.Url.envelope.rawValue
                , "xmlns:tem"     : Service.Url.tempuri.rawValue
            ]
            
            let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: envelopeAttributes)
            let body = envelope.addChild(name: "soapenv:Body")
            let GetForexStocksandIndexesInfo = body.addChild(name: "tem:GetForexStocksandIndexesInfo")
            let request = GetForexStocksandIndexesInfo.addChild(name: "tem:request")
            request.addChild(name: "tem:IsIPAD").value = "true"
            request.addChild(name: "tem:DeviceID").value = "test"
            request.addChild(name: "tem:DeviceType").value = "ipad"
            request.addChild(name: "tem:RequestKey").value = requestKey
            request.addChild(name: "tem:Period").value = "Day"
            
            let soapLenth = String(soapRequest.xml.count)
            let theURL = URL(string: Service.Url.service.rawValue)
            
            var urlRequest = URLRequest(url: theURL!)
            urlRequest.addValue("mobileexam.veripark.com", forHTTPHeaderField: "Host")
            urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
            urlRequest.addValue("http://tempuri.org/GetForexStocksandIndexesInfo", forHTTPHeaderField: "SOAPAction")
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
            
            Alamofire.request(urlRequest).responseString { response in
                
                if let xmlString = response.result.value {
                    let xml = SWXMLHash.parse(xmlString)
                    let result = xml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]
                    
                    if result["RequestResult"]["Success"].element!.text == "true" {
                        let responseList = result["StocknIndexesResponseList"]
                        
                        var stocknIndexesResponseList = [StockandIndexes]()
                        for element in responseList["StockandIndex"].all {
                            let stocknIndexesResponse = StockandIndexes(
                                Symbol         : element["Symbol"].element!.text
                                , Price          : Double(element["Price"].element!.text)
                                , Difference     : Double(element["Difference"].element!.text)
                                , Volume         : Double(element["Volume"].element!.text)
                                , Buying         : Double(element["Buying"].element!.text)
                                , Selling        : Double(element["Selling"].element!.text)
                                , Hour           : element["Hour"].element!.text
                                , DayPeakPrice   : Double(element["DayPeakPrice"].element!.text)
                                , DayLowestPrice : Double(element["DayLowestPrice"].element!.text)
                                , Total          : Int(element["Total"].element!.text)
                                , IsIndex        : Bool(element["IsIndex"].element!.text)!
                            )
                            
                            stocknIndexesResponseList.append(stocknIndexesResponse)
                        }
                        
                        completion(stocknIndexesResponseList)
                    } else {
                        AlertFunctions.messageType.showOKAlert("HATA!", bodyMessage: "Bir hata oluştu. Lütfen tekrar deneyiniz.")
                    }
                    
                } else{
                    print("error fetching XML")
                    AlertFunctions.messageType.showOKAlert("ERROR!", bodyMessage: "Error fetching XML")
                }
            }
        }
    }
    
    
}
