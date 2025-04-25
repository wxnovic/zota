//
//  ContentView.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            TaskMainView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("HOME")
                    }
                }
            TaskCreateView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("Create Task")
                    }
                }
            AdminView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Admin")
                }
        }
        .accentColor(.orange) // 선택된 탭 색상
    }
}

#Preview {
    ContentView()
}
