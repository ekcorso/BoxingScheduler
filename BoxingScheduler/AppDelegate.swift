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
    let watchedClasses = WatchedClasses()
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
            
            /* Ideally the badge count would be taken from the push notification's apns value (set server side),
            but since I don't have a backend this will have to do */
            DispatchQueue.main.async {
                Task {
                    let availableClassCount = await self.getAvailableClassCount()
                    UIApplication.shared.applicationIconBadgeNumber = availableClassCount
                }
            }
            
            // TODO: Remove this call after testing the async/ await version above
//            getAvailableClassCount() { availableClassCount in
//                DispatchQueue.main.async {
//                    UIApplication.shared.applicationIconBadgeNumber = availableClassCount
//                }
//            }
            
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
        print("Received remote notification!")
        
        checkForNewAvailableClasses() {
            completionHandler(.newData)
        }
        
        // TODO: Remove this network call after testing the async/ await version above
        //        Networking.fetchScheduleData() { (schedule) in
        //            NotificationCenter.default.post(name: .newScheduleData, object: self, userInfo: ["schedule": schedule])
        //        }
        
        
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
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // This gets called when a notification is tapped (even if the app is in the background)
//        print("DidReceive without fetchCompletionHandler was called (prob in foreground)")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("WillPresent was called")
        // This got called by a non-silent notification when the app was foregrounded
        completionHandler([.banner, .badge, .sound])
    }
    
    // MARK: Other methods
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
            Networking.urlSession.invalidateAndCancel()
        }
        
        // TODO: Remove this network call after testing the async/ await version below
//        Networking.fetchScheduleData() { (schedule) in
//            NotificationCenter.default.post(name: .newScheduleData, object: self, userInfo: ["schedule": schedule])
//            task.setTaskCompleted(success: true)
//        }
        
        Task {
            let schedule = await Networking.fetchScheduleData()
            NotificationCenter.default.post(name: .newScheduleData, object: self, userInfo: ["scheudle": schedule])
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
    
    func getAvailableClassCount() async -> Int {
        let allClassList = await WatchedClasses().getAllClasses()
        let nowAvailableClassCount = WatchedClasses().filterForNowAvailableClasses(from: allClassList).count
        
        if nowAvailableClassCount >= 1 {
            return nowAvailableClassCount
        } else {
            return -1
        }
    }
    
    func checkForNewAvailableClasses(_ completion: @escaping () -> Void) {
        Task {
            var schedule = await Networking.fetchScheduleData()
            
            // This fake class is for testing push notifications. Tbh, not sure if it works
//            let tommorrow = Calendar.current.date(byAdding: DateComponents(hour: 12), to: .now)!
//            let fakeClassDate = ClassDate(date: .now, classes: [MbaClass(name: ClassType.morningBodyBlastFridays.rawValue, spotsAvailable: "88", date: tommorrow)])
//            schedule.append(fakeClassDate)

            var allClasses = [MbaClass]()
            for date in schedule {
                for mbaClass in date.classes {
                    allClasses.append(mbaClass)
                }
            }
            
            let newAvailable = watchedClasses.filterForNowAvailableClasses(from: allClasses) // does this update nowAvailable?
            let previousAvailable = DataStorage().retrieveNowAvailable() ?? []
            
            // remove classes that have passed
            let now = Date()
            let previousAvailableWithPastClassesRemoved = previousAvailable.filter() { $0.date >= now }
            
            if newAvailable != previousAvailableWithPastClassesRemoved {
                
                // Note that this will be triggered every time the push notification is received (prob hourly) as long as a watched class is available
                // The user will need to remove the watched class in order to stop triggering the notification (with or without signing up for it)
                NotificationHandler().scheduleAvailableClassNotification()
                
                do {
                    // save nowAvailable so the next time this get's triggered it will be the correct nowAvailable list
                    try DataStorage().saveNowAvailable(newAvailable)
                } catch {
                    print("Saving failed")
                }
            }
            
            // Is this necessary at all? I think the notificationHandler call above is what is actually triggering the local notification
//            NotificationCenter.default.post(name: .newScheduleData, object: self, userInfo: ["schedule": schedule])

            completion()
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        var tokenDict = ["token": ""]
        if let unwrappedToken = fcmToken {
            tokenDict = ["token": unwrappedToken]
        } else {
            // This should be a log
            print("fcmToken was nil!")
        }
        
//        print("Token = \(fcmToken)")
        NotificationCenter.default.post(name: .fcmToken, object: nil, userInfo: tokenDict)
    }
}
