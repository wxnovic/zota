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
        TabView{
            MainView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            Rectangle()
                .tabItem{
                    Image(systemName: "plus")
                    Text("Add")
                }
        }
    }
   
}



#Preview {
    ContentView()
}
