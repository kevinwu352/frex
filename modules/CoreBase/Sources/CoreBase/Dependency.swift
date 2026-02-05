//
//  Dependency.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import Foundation
import Factory

public extension Scope {
  static let session = Cached()
}

// public extension Container {
//   var service: Factory<MyService> {
//     self { MyService(value: "aaa") }.cached
//   }
// }
//
// public class MyService: CustomStringConvertible {
//   let value: String
//   init(value: String) {
//     self.value = value
//   }
//   public var description: String {
//     "MyService:\(value)"
//   }
// }
