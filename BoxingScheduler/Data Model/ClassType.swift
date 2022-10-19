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
    
    func getStartTime(for className: Name) -> ClassTime {
        // Rather than elaborate parsing, use the Name enum and give them associated values, then just switch over those returning the appropriate time. Pros: more readable. Cons: more brittle, less "cool"
        switch className {
        case Name.morningBodyBlastMondays:
            return ClassTime(hours: 6, minutes: 30, seconds: 0)
        case Name.footworkFundamentalsMondays:
            return ClassTime(hours: 17, minutes: 0, seconds: 0)
        case Name.advancedFootwork:
            return ClassTime(hours: 18, minutes: 15, seconds: 0)
        case Name.lunchTimeBoxingPowerHourTuesdays:
            return ClassTime(hours: 12, minutes: 0, seconds: 0)
        case Name.cardioBoxingTuesdays5:
            return ClassTime(hours: 17, minutes: 0, seconds: 0)
        case Name.cardioBoxingTuesdays615:
            return ClassTime(hours: 18, minutes: 15, seconds: 0)
        case Name.boxingSkillsTuesdays:
            return ClassTime(hours: 19, minutes: 15, seconds: 0)
        case Name.morningBodyBlastWednesdays:
            return ClassTime(hours: 6, minutes: 30, seconds: 0)
        case Name.combatConditioningWednesdays:
            return ClassTime(hours: 17, minutes: 0, seconds: 0)
        case Name.TeamPracticeWednesdays:
            return ClassTime(hours: 18, minutes: 0, seconds: 0)
        case Name.lunchTimeBoxingPowerHourThursdays:
            return ClassTime(hours: 12, minutes: 0, seconds: 0)
        case Name.cardioBoxingThursdays5:
            return ClassTime(hours: 17, minutes: 0, seconds: 0)
        case Name.cardioBoxingThursdays615:
            return ClassTime(hours: 18, minutes: 15, seconds: 0)
        case Name.boxingSkillsThursdays:
            return ClassTime(hours: 19, minutes: 15, seconds: 0)
        case Name.morningBodyBlastFridays:
            return ClassTime(hours: 6, minutes: 30, seconds: 0)
        case Name.combatConditioningFridays:
            return ClassTime(hours: 17, minutes: 0, seconds: 0)
        case Name.teamPracticeFridays:
            return ClassTime(hours: 18, minutes: 0, seconds: 0)
        case Name.cardioBoxingSaturdays9:
            return ClassTime(hours: 9, minutes: 0, seconds: 0)
        case Name.cardioBoxingSaturdays1030:
            return ClassTime(hours: 10, minutes: 15, seconds: 0)
        default:
            return ClassTime(hours: 0, minutes: 0, seconds: 0)
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
