//
//  zotaApp.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI
import SwiftData

@main
struct zotaApp: App {
    @Environment(\.modelContext) var context: ModelContext

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            UserModel.self,
            CategoryModel.self,
            ItemModel.self,
            TaskModel.self,
            DayModel.self,
            BombModel.self
        ])
        
    }
    
    
}
