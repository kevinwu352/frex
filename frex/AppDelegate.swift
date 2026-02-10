//
//  AppDelegate.swift
//  frex
//
//  Created by Kevin Wu on 2/4/26.
//

import UIKit

@MainActor
func customNavBarAppearance1() -> UINavigationBarAppearance {
  let ret = UINavigationBarAppearance()

  // Apply a red background.
  ret.configureWithOpaqueBackground()
  ret.backgroundColor = .red

  // Apply green colored normal and large titles.
  ret.titleTextAttributes = [.foregroundColor: UIColor.green]
  ret.largeTitleTextAttributes = [.foregroundColor: UIColor.green]

  // Apply white color to all the nav bar buttons.
  let item = UIBarButtonItemAppearance(style: .plain)
  item.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
  item.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
  item.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
  item.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
  ret.buttonAppearance = item
  ret.backButtonAppearance = item
  ret.doneButtonAppearance = item

  return ret
}

@MainActor
func customNavBarAppearance2() -> UINavigationBarAppearance {
  let ret = UINavigationBarAppearance()

  // Apply a red background.
  ret.configureWithOpaqueBackground()
  ret.backgroundColor = .blue

  // Apply green colored normal and large titles.
  ret.titleTextAttributes = [.foregroundColor: UIColor.green]
  ret.largeTitleTextAttributes = [.foregroundColor: UIColor.green]

  // Apply white color to all the nav bar buttons.
  let item = UIBarButtonItemAppearance(style: .plain)
  item.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
  item.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
  item.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
  item.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
  ret.buttonAppearance = item
  ret.backButtonAppearance = item
  ret.doneButtonAppearance = item

  return ret
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication
      .LaunchOptionsKey: Any]?
  ) -> Bool {
    // Override point for customization after application launch.
#if DEBUG
    print(NSHomeDirectory())
#endif

    let navBarAppearance1 = customNavBarAppearance1()
    // let navBarAppearance2 = customNavBarAppearance2()
    let appearance = UINavigationBar.appearance()
    appearance.standardAppearance = navBarAppearance1
    appearance.compactAppearance = navBarAppearance1
    appearance.scrollEdgeAppearance = navBarAppearance1
    appearance.compactScrollEdgeAppearance = navBarAppearance1

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    print("configuration for connecting")
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly
    // after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

}
