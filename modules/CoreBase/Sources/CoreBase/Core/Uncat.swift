//
//  Uncat.swift
//  frex
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation

public func withValue<T1, T2>(_ value: T1, _ handler: (T1) -> T2) -> T2 {
  handler(value)
}

extension Result {
  public var isSuccess: Bool {
    if case .success = self { true } else { false }
  }
  public var isFailure: Bool {
    if case .failure = self { true } else { false }
  }
}
// (200..<300).contains((obj as? HTTPURLResponse)?.statusCode ?? 0)

extension Bundle {
  public var versionNumber: String? {
    infoDictionary?["CFBundleShortVersionString"] as? String
  }
  public var buildNumber: String? {
    infoDictionary?["CFBundleVersion"] as? String
  }
}
