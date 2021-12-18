//
//  MbaClass.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/1/21.
//

import Foundation

class MbaClass {
    // name could have an enum
    var name: String
    var spotsAvailable: Int = 0
    var date: Date = Date()
    
    init(name: String, spotsAvailable: String, date: String) {
        self.name = name
        self.spotsAvailable = getSpotsAsInt(from: spotsAvailable)
        self.date = date.toDate() ?? Date()
    }
    
    private func getSpotsAsInt(from spotsString: String) -> Int {
        var spotsInt: Int = 0
        if let num = Int(spotsString.components(separatedBy: .decimalDigits.inverted).joined()) {
            spotsInt = num
        }
        return spotsInt
    }
    
    private func getClasstime(fromName: String) -> String {
        // Could use regular expression to parse times from class that give one, else use a switch statement to check for classes at known times
        // Or rather than eleaborate parsing, use the ClassType enum and give them associated values, then just switch over those returning the appropriate time. Pros: more readable. Cons: more brittle, less "cool"
        return ""
    }
}

extension MbaClass: Equatable {
    static func == (lhs: MbaClass, rhs: MbaClass) -> Bool {
        //this will be a problem as the fetches update classes from different days that have the same name + spotsAvailable. Need to add dates to classes
        if lhs.name == rhs.name && lhs.spotsAvailable == rhs.spotsAvailable {
            return true
        } else {
            return false
        }
    }
}
