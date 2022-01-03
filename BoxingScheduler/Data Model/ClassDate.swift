//
//  ClassDate.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/4/21.
//

import Foundation

class ClassDate {
    // exactDate should eventually be passed into a DateFormatter()
    var exactDate: String?
    var classes: [MbaClass] = [MbaClass]()
}

extension ClassDate: Comparable {
    static func < (lhs: ClassDate, rhs: ClassDate) -> Bool {
        if let leftDate = lhs.exactDate?.toDate(), let rightDate = rhs.exactDate?.toDate() {
        return leftDate < rightDate
        } else {
            return false
        }
    }
    
    static func == (lhs: ClassDate, rhs: ClassDate) -> Bool {
        if let leftDate = lhs.exactDate?.toDate(), let rightDate = rhs.exactDate?.toDate() {
        return leftDate == rightDate
        } else {
            return false
        }
    }
}
