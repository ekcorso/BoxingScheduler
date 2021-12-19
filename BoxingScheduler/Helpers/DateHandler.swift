//
//  DateHandler.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import Foundation

struct DateHandler {
    private let dateFormat = "MMM d, yyyy HH:mm"
    let formatter: DateFormatter
    
    init() {
        formatter = DateFormatter(format: dateFormat)
    }
}
