//
//  DateHelper.swift
//  MobileTestApp
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

enum DateFormats: String {
    case timestamp = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}
class DateHelper: NSObject {
    static let sharedInstance = DateHelper()
    static let formatter = DateFormatter()

    func transform(string: String, format: DateFormats = .timestamp) -> Date? {
        DateHelper.formatter.dateFormat = format.rawValue
        return DateHelper.formatter.date(from: string)
    }
}
