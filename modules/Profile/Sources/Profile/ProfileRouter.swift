//
//  ProfileRouter.swift
//  Profile
//
//  Created by Kevin Wu on 2/15/26.
//

import UIKit

@MainActor
public struct ProfileRouter {
  public static func createProfileVc() -> UIViewController {
    ProfileViewController()
  }
}
