//
//  DateHandler.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import Foundation

struct DateHandler {
    static let dateInputFormat = "MMM d, yyyy HH:mm"
    static let mdyDateInputFormat = "MMMM d, yyyy" // Note this will produce dates initialized to noon on this day
    static let shortOutputFormat = "MMM d h:mm a"
    static let longOutputFormat = "EEEE, MMM d, yyyy"
    
    let formatter: DateFormatter
    
    init() {
        // default init assumes this is input for parsing the date format of a string
        formatter = DateFormatter(format: DateHandler.dateInputFormat)
    }
    
    init(format: String) {
        // alt init allows the user to specify the format, in case there are multiple output formats in the future
        formatter = DateFormatter(format: format)
    }
}
