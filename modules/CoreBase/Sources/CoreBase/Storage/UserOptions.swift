//
//  UserOptions.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import Foundation
import Factory

extension Container {
  @MainActor
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
  }
  deinit { print("options, deinit") }

  public var accountBalanceMasked: Bool {
    willSet { raw.setBool(newValue, forKey: "account_balance_masked") }
  }
}
