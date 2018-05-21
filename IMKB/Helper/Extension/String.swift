//
//  String.swift
//  IMKB
//
//  Created by Yunus Tek on 20.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation

extension String {
    func ToDate() -> Date {
        let formatter = DateFormatter()
        // 2018-04-11 22:14:05
        // 2018-05-20T00:00:00
        let date = self.replacingOccurrences(of: "T", with: " ")
        if date.count <= 10 {
            formatter.dateFormat = "dd/MM/yyyy"
        } else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        
        return formatter.date(from: date)!
    }
    
}
