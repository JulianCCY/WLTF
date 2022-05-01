//
//  WLTFApp.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//

import SwiftUI

@main
struct WLTFApp: App {
    
    // To enable coredata working across all the files in this project
    @StateObject private var datacontroller = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView ()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
//                .environment(\.locale, .init(identifier: "fi"))
        }
    }
}
