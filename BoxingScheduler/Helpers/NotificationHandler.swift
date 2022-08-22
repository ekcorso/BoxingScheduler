//
//  NotificationHandler.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/30/21.
//

import Foundation
import UIKit
import NotificationCenter

class NotificationHandler {
    
    func registerNotifications() {
        let center = UNUserNotificationCenter.current()
        
        // TODO: Remove sound?
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Permission granted")
                DispatchQueue.main.async {
                    SettingsViewController().registerNotificationsButton.isEnabled.toggle()
                }
            } else {
                print("Permission denied")
            }
        }
    }
    
    func scheduleAvailableClassNotification() {
        let watchedClasses = WatchedClasses()
        Task {
            let allClasses = await watchedClasses.getAllClasses()
            let availableClasses = watchedClasses.getNowAvailableClasses(from: allClasses)
            
            if !availableClasses.isEmpty {
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                content.title = "Class Available"
                content.body = "Go to MBA website to sign up"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                try? await center.add(request) // TODO: This needs testing
                
                print("Notification scheduled")
            } else {
                print("No notifications")
            }
        }
    }
}
