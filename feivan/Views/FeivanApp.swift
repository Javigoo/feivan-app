//
//  FeivanApp.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import SwiftUI

@main
struct FeivanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
