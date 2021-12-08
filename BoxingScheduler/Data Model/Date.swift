//
//  Date.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/4/21.
//

import Foundation

class Date {
    // exactDate should eventually be passed into a DateFormatter()
    var exactDate: String
    var classes: [MbaClass]
    
    init(exactDate: String, classes: [MbaClass]) {
        self.exactDate = exactDate
        self.classes = classes
    }
}
