//
//  Reminders.swift
//  TabletTimer
//
//  Created by Daniel Pape on 20/08/2020.
//

import Foundation
import UserNotifications

func requestPermission (){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            print("Notification permission success")
//            self.notificationPermission = true
            let defaults = UserDefaults.standard
            defaults.setValue(true, forKey: "notificationpermission")
            defaults.synchronize()
//            showingNotificationPermission.toggle()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
//                homeData.isNewData.toggle()
//            }
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
}

func scheduleNotification(minutes: TimeInterval){
    let content = UNMutableNotificationContent()
    content.title = "It is now safe to take Paracetamol"
//        content.subtitle = "It is now safe to take \(tablet)"
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: minutes*60, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request)
    
    print(request)
}

func cancelNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    
}
