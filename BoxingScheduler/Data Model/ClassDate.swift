//
//  ClassDate.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/4/21.
//

import Foundation

class ClassDate {
    var exactDate: Date?
    var classes: [MbaClass]
    
    init(date: String, dateFormat: String, classes: [MbaClass]) {
        self.exactDate = date.toDate(format: dateFormat)
        self.classes = classes
    }
    
    init(date: Date, classes: [MbaClass]) {
        self.exactDate = date
        self.classes = classes
    }
    
    init() {
        self.exactDate = nil
        self.classes = [MbaClass]()
    }
}

extension ClassDate: Comparable {
    static func < (lhs: ClassDate, rhs: ClassDate) -> Bool {
        if let leftDate = lhs.exactDate, let rightDate = rhs.exactDate {
            return leftDate < rightDate
        } else {
            return false
        }
    }
    
    static func == (lhs: ClassDate, rhs: ClassDate) -> Bool {
        if let leftDate = lhs.exactDate, let rightDate = rhs.exactDate {
            return leftDate == rightDate
        } else {
            return false
        }
    }
}
