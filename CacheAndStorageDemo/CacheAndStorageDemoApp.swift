//
//  CacheAndStorageDemoApp.swift
//  CacheAndStorageDemo
//
//  Created by Yangyang Wen on 2022/8/3.
//

import SwiftUI

@main
struct CacheAndStorageDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
