//
//  dogFoodTrackerApp.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct dogFoodTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("Finish launching!")
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID =
            FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

      if let error = error {
        print(error.localizedDescription)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (res, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print(res!.user.email)
            UserDefaults.standard.set(true, forKey: "status")
            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
}
