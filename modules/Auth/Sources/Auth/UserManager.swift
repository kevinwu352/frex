//
//  UserManager.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import CoreBase
import Foundation

final class UserManager: UserManaging {
  init(_ user: User) {
    print("usermg, init, [\(user.username)]")
    self.user = user
  }
  deinit { print("usermg, deinit") }

  var user: User

  func updatePhone(_ phone: String) {
  }
}

extension UserManager: @preconcurrency CustomStringConvertible {
  var description: String {
    "usermg [\(user.username)]"
  }
}
