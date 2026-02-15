//
//  Secures.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import Foundation
import Factory
import KeychainSwift

extension Container {
  public var secures: Factory<Secures> {
    self { @MainActor in Secures(persist: true) }.cached
  }
}

@MainActor
public final class Secures {
  public let raw: KeychainSwift?
  public init(persist: Bool) { // LABEL
    print("secures, init, persist:\(persist)")
    raw = persist ? KeychainSwift() : nil

    accessToken = raw?.get("access_token")

    doNotChange = 0
  }
  let doNotChange: Int
  deinit { print("secures, deinit") }

  @After public var accessToken: String? {
    willSet {
      if let value = newValue {
        raw?.set(value, forKey: "access_token")
      } else {
        raw?.delete("access_token")
      }
    }
  }
}
