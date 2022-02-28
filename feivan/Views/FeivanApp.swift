//
//  FeivanApp.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Feivan application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
        return true
    }
    let persistenceController = PersistenceController.shared
}

@main
struct FeivanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, delegate.persistenceController.container.viewContext)
        }
    }
}
