//
//  zotaApp.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI

@main
struct zotaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
