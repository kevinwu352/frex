//
//  Deps.swift
//  frex
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation
import Factory

public extension Scope {
  static let sess = Cached()
}

public extension Container {
  var service: Factory<SomeService> {
    self { SomeService(value: "aaa") }.cached
  }
}

public final class SomeService {
  let value: String
  init(value: String) {
    self.value = value
  }
}
