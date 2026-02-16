//
//  Dependency.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import Foundation
import Factory

// singleton
// graph
// unique / shared / cached

// self { Router() }.scope(.session)
extension Scope {
  public static let session = Cached()
}

// 前三个可以随用随取，而后面几个跟用户相关的，最好弄成属性，使用它的类新建的时候就注入
// 而不是后面用的时候再取，这样可避免后面取到不属于自己的实例，可能有这种可能性
// 比如登入登出的时候
//
// let defaults = Container.shared.defaults()   // main             cached
// let secures = Container.shared.secures()     // main             cached
//
// let switcher = Container.shared.switcher()   // main             cached
// let options = Container.shared.options()     // main             session
// let network = Container.shared.network()     // send protocol    session
// let usermg = Container.shared.usermg()       // main protocol    session

// extension Container {
//   public var service: Factory<MyService> {
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
