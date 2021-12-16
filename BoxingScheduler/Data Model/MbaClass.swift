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
