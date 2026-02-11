//
//  Defaults.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import Foundation
import Factory

extension Container {
  @MainActor
  public var defaults: Factory<Defaults> {
    self { @MainActor in Defaults(persist: true) }.cached
  }
}

@MainActor
public final class Defaults {
  public let raw: Storage
  public init(persist: Bool) { // LABEL
    print("defaults, init, persist:\(persist)")
    raw = Storage(persist ? pathmk("defaults.json") : "")

    boardedVersion = raw.string(forKey: "boarded_version")

    lastUsername = raw.string(forKey: "last_username")

    theme = raw.string(forKey: "theme_code")
    language = raw.string(forKey: "language_code")
  }
  deinit { print("defaults, deinit") }

  @After public var boardedVersion: String? {
    willSet { raw.setString(newValue, forKey: "boarded_version") }
  }

  @After public var lastUsername: String? {
    willSet { raw.setString(newValue, forKey: "last_username") }
  }

  @After public var theme: String? {
    willSet { raw.setString(newValue, forKey: "theme_code") }
  }
  @After public var language: String? {
    willSet { raw.setString(newValue, forKey: "language_code") }
  }
}
