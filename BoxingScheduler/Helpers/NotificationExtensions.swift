//
//  NotificationExtensions.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 8/11/22.
//

import Foundation

extension Notification.Name {
    static let newScheduleData = Notification.Name("com.emilykcorso.fetchScheduleData")
    static let newAvailableClasses = Notification.Name("com.emilykcorso.fetchAvailableClasses")
    static let classDataFetchComplete = Notification.Name("classDataFetchComplete")
    static let fcmToken =  Notification.Name("FCMToken")
}
