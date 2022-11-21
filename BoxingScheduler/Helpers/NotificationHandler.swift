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
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                // TODO: Create custom content for this depending on the class
                content.title = "Class Available"
                content.body = "Go to MBA website to sign up"
                                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                try? await center.add(request)
//                print("Notification scheduled")
        }
    }
}
