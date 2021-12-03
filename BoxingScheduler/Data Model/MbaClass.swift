//
//  MbaClass.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/1/21.
//

import Foundation

struct MbaClass {
    // name could have an enum
    var name: String
    // Look into how date is formatted-- this might require some conversion/ use of a DateFormatter
    var date: Date
    // Looks like the data is passed in as an int, but it might make more sense to convert this to a Bool or optional
    var spotsAvailable: Int
}
