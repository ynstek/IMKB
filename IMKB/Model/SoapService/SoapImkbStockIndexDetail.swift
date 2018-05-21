//
//  SoapImkbStockIndexDetail.swift
//  IMKB
//
//  Created by Yunus Tek on 20.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//


import Foundation
import Alamofire
import SWXMLHash
import StringExtensionHTML
import AEXML

private let _sharedSoapImkbStockIndexDetail = SoapImkbStockIndexDetail()
class SoapImkbStockIndexDetail: NSObject {
    
    class var shared : SoapImkbStockIndexDetail {
        return _sharedSoapImkbStockIndexDetail
    }
    
    lazy var list: [StockandIndexGraphic] = {
        return [StockandIndexGraphic]()
    }()
    
    class func getList(symbol: String, period: Service.Period, completion: @escaping (_ response: [StockandIndexGraphic]) -> Void) {
        SoapEncrypt.getRequestIsValid { (requestKey) in
            let soapRequest = AEXMLDocument()
            Service.addChilds(soapRequest, requestKey: requestKey, period: period, symbol: symbol)
            
            let theURL = URL(string: Service.Url.service.rawValue)
            let action = "GetForexStocksandIndexesInfo"
            let urlRequest = Service.addValues(soapRequest, theURL: theURL!, SOAPaction: Service.Url.tempuri.rawValue + action)
            
            Alamofire.request(urlRequest).responseString { response in
                if let xmlString = response.result.value {
                    let xml = SWXMLHash.parse(xmlString)
                    let result = xml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]
                    
                    if result["RequestResult"]["Success"].element!.text == "true" {
                        var graphicList = [StockandIndexGraphic]()
                        
                        // MARK: StocknIndexesResponseList
                        let responseList = result["StocknIndexesGraphicInfos"]
                        for element in responseList["StockandIndexGraphic"].all {
                            let response = StockandIndexGraphic(
                                  price: Double(element["Price"].element!.text)
                                , date: element["Date"].element!.text.ToDate()
                            )
    
                            graphicList.append(response)
                        }
                        graphicList.sort { (a, b) -> Bool in
                            return a.date! < b.date!
                        }
                        
                        completion(graphicList)
                    } else {
                        AlertFunctions.messageType.showOKAlert("HATA!", bodyMessage: "Bir hata oluştu. Lütfen tekrar deneyiniz.")
                    }
                    
                } else{
                    AlertFunctions.messageType.showOKAlert("HATA!", bodyMessage: "Bir hata oluştu. Lütfen tekrar deneyiniz.")
                }
            }
        }
    }
    
    
}
