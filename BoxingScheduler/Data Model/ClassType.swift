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
    
}
