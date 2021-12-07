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
    var spotsAvailable: Int?
    
    init(name: String, spotsAvailable: Int?) {
        self.name = name
        self.spotsAvailable = spotsAvailable
    }
    // Look into how date is formatted-- this might require some conversion/ use of a DateFormatter
    //var date: Date
}
