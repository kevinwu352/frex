//
//  UserManager.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation
import Factory

extension Container {
  public var usermg: Factory<UserManaging> {
    self { @MainActor in UserManagerPh(.init()) }.scope(.session)
  }
}

@MainActor
public protocol UserManaging {
  var user: User { get }
  func updatePhone(_ phone: String)
}

final class UserManagerPh: UserManaging {
  init(_ user: User) {
    print("usermg, init, [mock]")
    self.user = user
    assert(false, "should not be called")
  }
  deinit { print("usermg, deinit, [mock]") }

  var user: User

  func updatePhone(_ phone: String) {
    user = user.copyWith(phone: phone)
  }
}

extension UserManagerPh: @preconcurrency CustomStringConvertible {
  var description: String {
    "usermg [mock]"
  }
}
