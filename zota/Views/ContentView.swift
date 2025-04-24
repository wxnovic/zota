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
            MainView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("HOME")
                    }
                }
            
            DataEntryView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("HOME")
                    }
                }
            MasterListView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("HOME")
                    }
                }
        }
        .accentColor(.orange) // 선택된 탭 색상
    }
}

#Preview {
    ContentView()
}
