//
//  UserOptions.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import Factory
import Foundation

extension Container {
  public var options: Factory<UserOptions> {
    self { @MainActor in UserOptions(uid: "", persist: true) }.scope(.session)
  }
}

@MainActor
public final class UserOptions {
  public let raw: Storage
  public init(uid: String, persist: Bool) { // LABEL
    print("options, init, uid:\(uid), persist:\(persist)")
    raw = Storage(persist ? pathmk("options.json", uid: uid.isEmpty ? "shared" : uid) : "")

    accountBalanceMasked = raw.bool(forKey: "account_balance_masked") ?? false

    doNotChange = 0
  }
  let doNotChange: Int
  deinit { print("options, deinit") }

  @After public var accountBalanceMasked: Bool {
    willSet {
      print("options, account_balance_masked, \(accountBalanceMasked) => \(newValue)")
      raw.setBool(newValue, forKey: "account_balance_masked")
    }
  }
}
