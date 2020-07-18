//
//  AppDelegate.swift
//  NotificationSample
//
//  Created by 中村拓馬 on 2020/05/15.
//  Copyright © 2020 Nakamuratakuma. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // notification center (singleton)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        // ------------------------------------
        // 前準備: ユーザに通知の許可を求める
        // ------------------------------------
        
        // request to notify for user
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        }
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert, .sound])  // 通知バナー表示、通知音の再生を指定
        
        //ログイン中だったら
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "EventDetail")
        self.window?.rootViewController = rootViewController
        self.window?.backgroundColor = UIColor.black
        self.window?.makeKeyAndVisible()
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
         //windowを生成
                       self.window = UIWindow(frame: UIScreen.main.bounds)
                       //Storyboardを指定
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)

                       //推移先を指定
                       let initialViewController = storyboard.instantiateViewController(withIdentifier:"EventDetail")
                       self.window?.rootViewController = initialViewController
                       self.window?.makeKeyAndVisible()

                       completionHandler()
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
    
    
}

