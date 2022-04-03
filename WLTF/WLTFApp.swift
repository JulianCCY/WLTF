//
//  WLTFApp.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//

import SwiftUI

@main
struct WLTFApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
