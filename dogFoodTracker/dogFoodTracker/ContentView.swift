//
//  ContentView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        //LoginView()
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            DashboardView()
                .tabItem {
                    Label("Dashbord", systemImage: "list.dash")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }.accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
