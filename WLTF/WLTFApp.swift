//
//  WLTFApp.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//

import SwiftUI

@main
struct WLTFApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject private var datacontroller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
        }
    }
}
