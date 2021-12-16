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
    // Look into how date is formatted-- this might require some conversion/ use of a DateFormatter
    //var date: Date
    
    init(name: String, spotsAvailable: String) {
        self.name = name
        self.spotsAvailable = getSpotsAsInt(from: spotsAvailable)
    }
    
    private func getSpotsAsInt(from spotsString: String) -> Int {
        var spotsInt: Int = 0
        if let num = Int(spotsString.components(separatedBy: .decimalDigits.inverted).joined()) {
            spotsInt = num
        }
        return spotsInt
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
