//
//  AuthRouter.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import CoreBase
import UIKit

@MainActor
public struct AuthRouter {
  public static func createOnboardVc() -> UIViewController {
    OnboardViewController()
  }

  public static func createLoginVc() -> UIViewController {
    LoginViewController()
  }

  public static func createUserManager(_ user: User) -> UserManaging {
    UserManager(user)
  }
}
