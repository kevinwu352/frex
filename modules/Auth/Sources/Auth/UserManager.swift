//
//  UserManager.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation
import CoreBase

public final class UserManager: UserManaging {
  public init(_ user: User) {
    print("usermg, init, [\(user.username)]")
    self.user = user
  }
  deinit { print("usermg, deinit") }

  public var user: User

  public func updatePhone(_ phone: String) {
  }
}

extension UserManager: @preconcurrency CustomStringConvertible {
  public var description: String {
    "usermg [\(user.username)]"
  }
}
