//
//  SceneDelegate.swift
//  frex
//
//  Created by Kevin Wu on 2/4/26.
//

import UIKit
import Combine
import CoreBase
import Factory
import Auth
import Home
import Line
import Profile

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  lazy var bag = Set<AnyCancellable>()

  var window: UIWindow?
  let configer = SceneConfiger()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new
    // (see `application:configurationForConnectingSceneSession` instead).
    print("scene will connect to session, window:\(window == nil ? "nil" : "some")")
    guard let scene = scene as? UIWindowScene else { return }

    window = UIWindow(windowScene: scene)
    if let value = Container.shared.defaults().theme?.value {
      window?.overrideUserInterfaceStyle = value
    }
//    let tab = UITabBarController()
//    tab.setViewControllers(tabs(), animated: false)
//    window?.rootViewController = tab
    window?.makeKeyAndVisible()

    bindEvents()
  }
  func bindEvents() {
    Publishers.CombineLatest(
      configer.$showOnboard.removeDuplicates(),
      configer.$logined.removeDuplicates()
    )
    .sink { [weak self] showOnboard, logined in
      guard let self else { return }
      if showOnboard {
        let vc = AuthRouter.createOnboardVc()
        let nav = NavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        self.window?.rootViewController = nav
      } else {
        if logined {
          //
        } else {
          let vc = AuthRouter.createLoginVc()
          let nav = NavigationController(rootViewController: vc)
          nav.isNavigationBarHidden = true
          self.window?.rootViewController = nav
        }
      }
    }
    .store(in: &bag)
  }

  func tabs() -> [UIViewController] {
    let item1 = UITabBarItem(title: "Home", image: .iconHomeN, selectedImage: .iconHomeH)
    item1.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.darkGray], for: .normal)
    item1.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.green], for: .selected)
    let nc1 = NavigationController(rootViewController: HomeViewController())
    nc1.isNavigationBarHidden = true
    nc1.tabBarItem = item1

    let item2 = UITabBarItem(title: "Line", image: .iconLineN, selectedImage: .iconLineH)
    item2.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.darkGray], for: .normal)
    item2.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.green], for: .selected)
    let nc2 = NavigationController(rootViewController: LineViewController())
    nc2.isNavigationBarHidden = true
    nc2.tabBarItem = item2

    let item3 = UITabBarItem(title: "Profile", image: .iconProfileN, selectedImage: .iconProfileH)
    item3.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.darkGray], for: .normal)
    item3.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.green], for: .selected)
    let nc3 = NavigationController(rootViewController: ProfileViewController())
    nc3.isNavigationBarHidden = true
    nc3.tabBarItem = item3

    return [nc1, nc2, nc3]
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }

}
