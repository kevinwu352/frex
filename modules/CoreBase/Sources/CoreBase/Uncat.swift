//
//  Uncat.swift
//  frex
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation

public func withValue<T1, T2>(_ v: T1, _ h: (T1) -> T2) -> T2 {
  h(v)
}


public extension Result {
  var isSuccess: Bool {
    if case .success = self { return true } else { return false }
  }
  var isFailure: Bool {
    if case .failure = self { return true } else { return false }
  }
}


public extension Bundle {
  var versionNumber: String? {
    infoDictionary?["CFBundleShortVersionString"] as? String
  }
  var buildNumber: String? {
    infoDictionary?["CFBundleVersion"] as? String
  }
}
