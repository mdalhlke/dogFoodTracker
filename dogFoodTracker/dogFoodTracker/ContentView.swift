//
//  ContentView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @AppStorage("log_status") var log_status = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemOrange

    }
    
    var body: some View {
        VStack {
            if status || log_status {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
        //            DashboardView()
        //                .tabItem {
        //                    Label("Dashbord", systemImage: "list.dash")
        //                }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                }.accentColor(.orange)
            } else {
                LoginView()
            }
        }
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
