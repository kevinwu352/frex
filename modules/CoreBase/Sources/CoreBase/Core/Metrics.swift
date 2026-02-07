//
//  Metrics.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/1/26.
//

import UIKit

// should be valid after UIWindow(windowScene: scene) in SceneDelegate
// .sorted { !$1.isKeyWindow } 会把 keyWindow 排前面
//   且保持 keyWindow 在原列表的顺序，但不应该依赖这一点，其它项的顺序会变
@MainActor public var mainWindow: UIWindow? {
  UIApplication.shared.connectedScenes
    .compactMap { $0 as? UIWindowScene }
    .flatMap { $0.windows }
    .sorted { !$1.isKeyWindow }
    .first
}
@MainActor public var modalTop: UIViewController? {
  var ret = mainWindow?.rootViewController
  while let vc = ret?.presentedViewController {
    ret = vc
  }
  return ret
}

@MainActor public let screenWidth: Double = {
  let ret = UIScreen.main.bounds.width
  assert(ret > 0, "`screenWidth` invalid")
  return ret
}()
@MainActor public let screenHeight: Double = {
  let ret = UIScreen.main.bounds.height
  assert(ret > 0, "`screenHeight` invalid")
  return ret
}()

@MainActor public let safeTop: Double = {
  let ret = mainWindow?.safeAreaInsets.top ?? 0
  assert(ret > 0, "`safeTop` invalid")
  return ret
}()
@MainActor public let safeBot: Double = {
  let ret = mainWindow?.safeAreaInsets.bottom ?? 0
  assert(ret > 0, "`safeBot` invalid")
  return ret
}()

@MainActor public let statusBarHeight: Double = {
  let ret = safeBot > 0 ? safeTop : 20
  assert(ret > 0, "`statusBarHeight` invalid")
  return ret
}()
public let navBarHeight = 44.0
public let tabBarHeight = 49.0

@MainActor public let topHeight = statusBarHeight + navBarHeight
@MainActor public let botHeight = safeBot + tabBarHeight
