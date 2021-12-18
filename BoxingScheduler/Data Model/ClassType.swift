//
//  ClassType.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/4/21.
//

import Foundation

enum ClassType: String {
    //give raw values that are strings for the class names, then create an getStartTime() func that switches over these are returns a time for each (time should be formatted with the dateFormatter eventually, but could be a string to start)
    case morningBodyBlastMondays = "Morning Body Blast Mondays (With Permission Only)"
    case footworkFundamentalsMondays = "Footwork FUNdamentals Mondays (With Permission Only)"
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
    
    func getStartTime(for mbaClass: ClassType) -> String {
        switch mbaClass {
        case .morningBodyBlastMondays:
            return "6:30am"
        case .footworkFundamentalsMondays:
            return "5:00pm"
        case .lunchTimeBoxingPowerHourTuesdays:
            return "12:00pm"
        case .cardioBoxingTuesdays5:
            return "5:00pm"
        case .cardioBoxingTuesdays615:
            return "6:15pm"
        case .boxingSkillsTuesdays:
            return "7:15pm"
        case .morningBodyBlastWednesdays:
            return "6:30am"
        case .combatConditioningWednesdays:
            return "5:00pm"
        case .TeamPracticeWednesdays:
            return "6:00pm"
        case .lunchTimeBoxingPowerHourThursdays:
            return "12:00pm"
        case .cardioBoxingThursdays5:
            return "5:00pm"
        case .cardioBoxingThursdays615:
            return "6:15pm"
        case .boxingSkillsThursdays:
            return "7:15pm"
        case .morningBodyBlastFridays:
            return "6:30am"
        case .combatConditioningFridays:
            return "5:00pm"
        case .teamPracticeFridays:
            return "6:00pm"
        case .cardioBoxingSaturdays9:
            return "9:00am"
        case .cardioBoxingSaturdays1030:
            return "10:15am"
        }
    }
}
