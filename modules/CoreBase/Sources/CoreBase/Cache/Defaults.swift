//
//  Defaults.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import Factory
import Foundation

extension Container {
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

    if let value = raw.string(forKey: "theme_code") {
      theme = Theme(rawValue: value)
    }
    language = raw.string(forKey: "language_code")

    doNotChange = 0
  }
  let doNotChange: Int
  deinit { print("defaults, deinit") }

  @After public var boardedVersion: String? {
    willSet {
      print("defaults, boarded_version, \(String(describing: boardedVersion)) => \(String(describing: newValue))")
      raw.setString(newValue, forKey: "boarded_version")
    }
  }

  @After public var lastUsername: String? {
    willSet {
      print("defaults, last_username, \(String(describing: lastUsername)) => \(String(describing: newValue))")
      raw.setString(newValue, forKey: "last_username")
    }
  }

  @After public var theme: Theme? {
    willSet {
      print("defaults, theme_code, \(String(describing: theme?.rawValue)) => \(String(describing: newValue?.rawValue))")
      raw.setString(newValue?.rawValue, forKey: "theme_code")
    }
  }
  @After public var language: String? {
    willSet {
      print("defaults, language_code, \(String(describing: language)) => \(String(describing: newValue))")
      raw.setString(newValue, forKey: "language_code")
    }
  }
}
