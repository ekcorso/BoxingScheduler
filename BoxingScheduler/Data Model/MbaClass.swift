//
//  MbaClass.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/1/21.
//

import Foundation

class MbaClass {
    // name could have an enum
    var name: String = ""
    var spotsAvailable: Int = 0
    var date: Date = Date()
    var time: String = ""
    
    init(name: String, spotsAvailable: String, date: String) {
        let fullDate = date + " \(getStartTime(for: name))"
        self.name = name
        self.spotsAvailable = getSpotsAsInt(from: spotsAvailable)
        self.date = fullDate.toDate() ?? Date()
    }
    
    private func getSpotsAsInt(from spotsString: String) -> Int {
        var spotsInt: Int = 0
        if let num = Int(spotsString.components(separatedBy: .decimalDigits.inverted).joined()) {
            spotsInt = num
        }
        return spotsInt
    }
    
    private func getStartTime(for className: String) -> String {
        // Rather than eleaborate parsing, use the ClassType enum and give them associated values, then just switch over those returning the appropriate time. Pros: more readable. Cons: more brittle, less "cool"
        switch className {
        case ClassType.morningBodyBlastMondays.rawValue:
            return "06:30"
        case ClassType.footworkFundamentalsMondays.rawValue:
            return "17:00"
        case ClassType.lunchTimeBoxingPowerHourTuesdays.rawValue:
            return "12:00"
        case ClassType.cardioBoxingTuesdays5.rawValue:
            return "17:00"
        case ClassType.cardioBoxingTuesdays615.rawValue:
            return "18:15"
        case ClassType.boxingSkillsTuesdays.rawValue:
            return "19:15"
        case ClassType.morningBodyBlastWednesdays.rawValue:
            return "06:30"
        case ClassType.combatConditioningWednesdays.rawValue:
            return "17:00"
        case ClassType.TeamPracticeWednesdays.rawValue:
            return "18:00"
        case ClassType.lunchTimeBoxingPowerHourThursdays.rawValue:
            return "12:00"
        case ClassType.cardioBoxingThursdays5.rawValue:
            return "17:00"
        case ClassType.cardioBoxingThursdays615.rawValue:
            return "18:15"
        case ClassType.boxingSkillsThursdays.rawValue:
            return "19:15"
        case ClassType.morningBodyBlastFridays.rawValue:
            return "06:30"
        case ClassType.combatConditioningFridays.rawValue:
            return "17:00"
        case ClassType.teamPracticeFridays.rawValue:
            return "18:00"
        case ClassType.cardioBoxingSaturdays9.rawValue:
            return "09:00"
        case ClassType.cardioBoxingSaturdays1030.rawValue:
            return "10:15"
        default:
            return "12:00"
        }
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
