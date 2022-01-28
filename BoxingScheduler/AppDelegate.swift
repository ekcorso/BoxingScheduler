//
//  AppDelegate.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import BackgroundTasks
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.emilykcorso.fetchScheduleData", using: nil) { (task) in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        FirebaseApp.configure()
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let token = deviceToken.reduce("") { $0 + String(format: "%02.2hhx", $1) }
      print("registered for notifications", token)
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
            Networking.urlSession.invalidateAndCancel()
        }
        
        Networking.fetchScheduleData() { (schedule) in
            NotificationCenter.default.post(name: .newScheduleData, object: self, userInfo: ["schedule": schedule])
            task.setTaskCompleted(success: true)
        }
        scheduleBackgroundScheduleFetch()
    }
    
    func scheduleBackgroundScheduleFetch() {
        let scheduleFetchTask = BGAppRefreshTaskRequest(identifier: "com.emilykcorso.fetchScheduleData")
        scheduleFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
            try BGTaskScheduler.shared.submit(scheduleFetchTask)
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
}

