//
//  ClassType.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/4/21.
//

import Foundation

struct ClassType {
    let name: Name?
    
    init(name: Name?) {
        self.name = name
    }
    
    enum Name: String {
        case morningBodyBlastMondays = "Morning Body Blast Mondays (With Permission Only)"
        case footworkFundamentalsMondays = "Footwork FUNdamentals"
        case advancedFootwork = "Advanced Footwork (With Permission Only)"
        case lunchTimeBoxingPowerHourTuesdays = "Lunch-Time Boxing Power Hour Tuesdays"
        case cardioBoxingTuesdays5 = "Cardio Boxing Tuesdays (5pm)"
        case cardioBoxingTuesdays615 = "Cardio Boxing Tuesdays (6:15pm)"
        case boxingSkillsTuesdays = "Boxing Skills Tuesdays (With Permission Only)"
        case morningBodyBlastWednesdays = "Morning Body Blast Wednesdays (With Permission Only)"
        case combatConditioningWednesdays = "Combat Conditioning Wednesdays"
        case TeamPracticeWednesdays = "Team Practice Wednesdays (With Permission Only)"
        case lunchTimeBoxingPowerHourThursdays = "Lunch-Time Boxing Power Hour Thursdays"
        case cardioBoxingThursdays5 = "Cardio Boxing Thursdays (5pm)"
        case cardioBoxingThursdays615 = "Cardio Boxing Thursdays (6:15pm)"
        case boxingSkillsThursdays = "Boxing Skills Thursdays (With Permission Only)"
        case morningBodyBlastFridays = "Morning Body Blast Fridays (With Permission Only)"
        case combatConditioningFridays = "Combat Conditioning Fridays"
        case teamPracticeFridays = "Team Practice Fridays (With Permission Only)"
        case cardioBoxingSaturdays9 = "Cardio Boxing Saturdays (9am)"
        case cardioBoxingSaturdays1030 = "Cardio Boxing Saturdays (10:30am)"
    }
    
    func getStartTime(for className: String) -> String {
        // Rather than elaborate parsing, use the Name enum and give them associated values, then just switch over those returning the appropriate time. Pros: more readable. Cons: more brittle, less "cool"
        switch className {
        case Name.morningBodyBlastMondays.rawValue:
            return "06:30"
        case Name.footworkFundamentalsMondays.rawValue:
            return "17:00"
        case Name.advancedFootwork.rawValue:
            // return "6:15pm" // Time format is incorrect
            return "18:15"
        case Name.lunchTimeBoxingPowerHourTuesdays.rawValue:
            return "12:00"
        case Name.cardioBoxingTuesdays5.rawValue:
            return "17:00"
        case Name.cardioBoxingTuesdays615.rawValue:
            return "18:15"
        case Name.boxingSkillsTuesdays.rawValue:
            return "19:15"
        case Name.morningBodyBlastWednesdays.rawValue:
            return "06:30"
        case Name.combatConditioningWednesdays.rawValue:
            return "17:00"
        case Name.TeamPracticeWednesdays.rawValue:
            return "18:00"
        case Name.lunchTimeBoxingPowerHourThursdays.rawValue:
            return "12:00"
        case Name.cardioBoxingThursdays5.rawValue:
            return "17:00"
        case Name.cardioBoxingThursdays615.rawValue:
            return "18:15"
        case Name.boxingSkillsThursdays.rawValue:
            return "19:15"
        case Name.morningBodyBlastFridays.rawValue:
            return "06:30"
        case Name.combatConditioningFridays.rawValue:
            return "17:00"
        case Name.teamPracticeFridays.rawValue:
            return "18:00"
        case Name.cardioBoxingSaturdays9.rawValue:
            return "09:00"
        case Name.cardioBoxingSaturdays1030.rawValue:
            return "10:15"
        default:
            return "12:00"
        }
    }
}

struct ClassTime {
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}
