//
//  AppDelegate.swift
//  CleanSwiftboilerplate
//
//  Created by Farhan Amjad on 24.06.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared: AppDelegate = {
      guard let appD = UIApplication.shared.delegate as? AppDelegate else {
        return AppDelegate()
      }
      return appD
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func unexpectedLogout() {
      //TODO
  //    UserDataManager.deleteUser()
  //    SessionManager.deleteSession()
  //    //Clear any local data if needed
  //    //Take user to onboarding if needed, do NOT redirect the user
  //    // if is already in the landing to avoid losing the current VC stack state.
  //    if window?.rootViewController is HomeViewController {
  //      AppNavigator.shared.navigate(to: OnboardingRoutes.firstScreen, with: .changeRoot)
  //    }
    }
}

