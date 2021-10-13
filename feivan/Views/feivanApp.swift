//
//  feivanApp.swift
//  feivan
//
//  Created by Javier Roig Gregorio on 4/6/21.
//

import SwiftUI

@main
struct feivanApp: App {
    
    //@Environment(\.scenePhase) var scenePhase
    
    let persistence = persistenceController.shared
        
    var body: some Scene {
        WindowGroup {
            homeView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
        
        /*
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
                case .background:
                    print("Scene is in background")
                    persistenceController.save()
                case .inactive:
                    print("Scene is inactive")
                case .active:
                    print("Scene is active")
                @unknown default:
                    print("Apple must have changed something")
            }
        }
        */
        
    }
}
