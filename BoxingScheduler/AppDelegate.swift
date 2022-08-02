//
//  AppDelegate.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import BackgroundTasks
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.emilykcorso.fetchScheduleData", using: nil) { (task) in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
            
            getAvailableClassCount() { availableClassCount in
                print("Available Class Count: \(availableClassCount)")
                DispatchQueue.main.async {
                    UIApplication.shared.applicationIconBadgeNumber = availableClassCount ?? -1
                }
            }
            
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
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
        Messaging.messaging().apnsToken = deviceToken
//        Messaging.messaging().token() { token, error in
//            print("This is the device token: \(String(describing: token))")
//        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("There was an error: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        Networking.fetchScheduleData() { (schedule) in
            NotificationCenter.default.post(name: .newScheduleData, object: self, userInfo: ["schedule": schedule])
        }
        
        /*
        let watchedClasses = WatchedClasses()
        watchedClasses.getAllClasses() { allClassList in
            var nowAvailableClasses = watchedClasses.getNowAvailableClasses(from: allClassList).sorted()
            
            //Insert test class into the data
            let fakeAvailableClass = allClassList[0]
            fakeAvailableClass.spotsAvailable = 5
            nowAvailableClasses.append(fakeAvailableClass)
            
            if nowAvailableClasses.isEmpty == false {
                NotificationCenter.default.post(name: .newAvailableClasses, object: self, userInfo: ["availableClasses": nowAvailableClasses])
            }
        }
        */
        
        print("Received remote notification!")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    // MARK: Other methods
    
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
    
    func getAvailableClassCount(_ completion: @escaping (Int) -> Void) {
        let watchedClasses = WatchedClasses()
        watchedClasses.getAllClasses() { allClassList in
            let nowAvailableClassCount = watchedClasses.getNowAvailableClasses(from: allClassList).count
            
            completion(nowAvailableClassCount)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let tokenDict = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: tokenDict)
    }
}
