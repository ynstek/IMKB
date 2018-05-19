//
//  Service.swift
//  IMKB
//
//  Created by Yunus Tek on 18.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation

class Service: NSObject {
    
    enum Url: String {
        case service = "http://mobileexam.veripark.com/mobileforeks/service.asmx"
        case xsi = "http://www.w3.org/2001/XMLSchema-instance"
        case xsd = "http://www.w3.org/2001/XMLSchema"
        case tempuri = "http://tempuri.org/"
        case envelope = "http://schemas.xmlsoap.org/soap/envelope/"
    }
}

