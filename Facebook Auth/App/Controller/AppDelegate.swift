//
//  AppDelegate.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 19.12.2020.
//

import UIKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        ApplicationDelegate.shared.application(application,
                                               didFinishLaunchingWithOptions: launchOptions )
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}




