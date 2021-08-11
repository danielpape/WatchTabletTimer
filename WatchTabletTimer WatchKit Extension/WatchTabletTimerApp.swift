//
//  WatchTabletTimerApp.swift
//  WatchTabletTimer WatchKit Extension
//
//  Created by Daniel Pape on 11/08/2021.
//

import SwiftUI

@main
struct WatchTabletTimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
