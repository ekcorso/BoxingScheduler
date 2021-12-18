//
//  Utilities.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import Foundation

extension String {
    //This func returns a string with unnecessary date info stripped out
    func extractDate() -> String {
        let weekdays = Calendar.current.weekdaySymbols
        let additionalDescriptors = ["Today", "Tomorrow", "Next Week", "In 2 Weeks", "In 3 Weeks"]
        var mutableString = self
        
        for day in weekdays {
            if self.contains(day) {
                let range = mutableString.range(of: day + ", ")
                mutableString.removeSubrange(range!)
                for word in additionalDescriptors {
                    if mutableString.contains(word) {
                        let wordRange = mutableString.range(of: " " + word)
                        mutableString.removeSubrange(wordRange!)
                    }
                }
            }
        }
        return mutableString
    }
}

extension String {
    func toDate() -> Date? {
        DateHandler().formatter.date(from: self.extractDate())
    }
}

extension DateFormatter {
    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
}

extension Date {
    func toString() -> String {
        DateHandler().formatter.string(from: self)
    }
}
