//
//  CoDeliApp.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/10/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct CoDeliApp: App {
    @StateObject private var firestoreData = FirestoreData()
    @StateObject private var realtimeData = RealtimeData()
    @StateObject private var internalData = InternalData()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(info: self.appDelegate)
                .environmentObject(firestoreData)
                .environmentObject(realtimeData)
                .environmentObject(internalData)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            print("AppDelegate!")

            GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
            GIDSignIn.sharedInstance().delegate = self

            return true
        }

    enum SignInState: Int {
        case fail = 0
        case success = 1
        case complete = 2
    }

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var isSignIn: SignInState? = .fail

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print("Failed to log into Google: ", error)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        // ...

        Auth.auth().signIn(with: credential) { [self] (authResult, error) in
//            if let error = error {
//                let authError = error as NSError
//                // ...
//                return
//            }

            // User is signed in
            // ...

            self.name = (authResult?.user.displayName)!
            self.email = (authResult?.user.email)!
            self.isSignIn = .success;
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
}
