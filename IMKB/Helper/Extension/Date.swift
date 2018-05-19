//
//  Date.swift
//  IMKB
//
//  Created by Yunus Tek on 18.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation

extension Date {
    func todayDate() -> String {
        let dateTime = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd:MM:yyyy HH:mm"
        //        return formatter.date(from: currentDate)! as Date
        return formatter.string(from: dateTime)
    }
}
