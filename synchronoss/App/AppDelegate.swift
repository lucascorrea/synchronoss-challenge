//
//  AppDelegate.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit
import UserNotifications
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Fabric
        Fabric.with([Crashlytics.self])
        
        // SCTwitter init
        SCTwitter.initWithConsumerKey("D6vneoIuMP0pdBZJAV7gg", consumerSecret: "wWc59eahiaES9ZCZ7wp28Rw4hcURG4fmIXvvwJiaR8")
        
        // Request authorization Notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, _) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

//
// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateCell"), object: notification)
    }
}
