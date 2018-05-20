//
//  SoapImkbStockIndexList.swift
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

private let _sharedSoapImkbStockIndexList = SoapImkbStockIndexList()
class SoapImkbStockIndexList: NSObject {
    
    class var shared : SoapImkbStockIndexList {
        return _sharedSoapImkbStockIndexList
    }
    
    lazy var list: [StockandIndexes] = {
        return [StockandIndexes]()
    }()

    lazy var selected: StockandIndexes? = nil
    
    class func getList(period: Service.Period, completion: @escaping (_ response: ForexResponse) -> Void) {
        SoapEncrypt.getRequestIsValid { (requestKey) in
            let soapRequest = AEXMLDocument()
            Service.addChilds(soapRequest, requestKey: requestKey, period: period)

            let theURL = URL(string: Service.Url.service.rawValue)
            let action = "GetForexStocksandIndexesInfo"
            let urlRequest = Service.addValues(soapRequest, theURL: theURL!, SOAPaction: Service.Url.tempuri.rawValue + action)

            Alamofire.request(urlRequest).responseString { response in
                
                if let xmlString = response.result.value {
                    let xml = SWXMLHash.parse(xmlString)
                    let result = xml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]
                    
                    if result["RequestResult"]["Success"].element!.text == "true" {
                        var forexResponse = ForexResponse()
                        
                        // MARK: StocknIndexesResponseList
                        var responseList = result["StocknIndexesResponseList"]
                        for element in responseList["StockandIndex"].all {
                            let response = StockandIndexes(
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
                            forexResponse.stockandIndexes.append(response)
                        }
                        forexResponse.stockandIndexes.sort { (a, b) -> Bool in
                            return a.Symbol! < b.Symbol!
                        }
                        
                        // MARK: IMKB100List
                        responseList = result["IMKB100List"]
                        for element in responseList["IMKB100"].all {
                            let response = ImkbVolume(
                                Symbol: element["Symbol"].element!.text
                                , Name: element["Name"].element!.text
                                , Gain: Double(element["Gain"].element!.text)
                                , Fund: Double(element["Fund"].element!.text)
                            )
                            
                            forexResponse.imkb100.append(response)
                        }
                        forexResponse.imkb100.sort { (a, b) -> Bool in
                            return a.Symbol! < b.Symbol!
                        }
                        
                        // MARK: IMKB50List
                        responseList = result["IMKB50List"]
                        for element in responseList["IMKB50"].all {
                            let response = ImkbVolume(
                                Symbol: element["Symbol"].element!.text
                                , Name: element["Name"].element!.text
                                , Gain: Double(element["Gain"].element!.text)
                                , Fund: Double(element["Fund"].element!.text)
                            )
                            
                            forexResponse.imkb50.append(response)
                        }
                        forexResponse.imkb50.sort { (a, b) -> Bool in
                            return a.Symbol! < b.Symbol!
                        }
                        
                        // MARK: IMKB30List
                        responseList = result["IMKB30List"]
                        for element in responseList["IMKB30"].all {
                            let response = ImkbVolume(
                                Symbol: element["Symbol"].element!.text
                                , Name: element["Name"].element!.text
                                , Gain: Double(element["Gain"].element!.text)
                                , Fund: Double(element["Fund"].element!.text)
                            )
                            
                            forexResponse.imkb30.append(response)
                        }
                        forexResponse.imkb30.sort { (a, b) -> Bool in
                            return a.Symbol! < b.Symbol!
                        }

                        completion(forexResponse)
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
