//
//  UIViewControllerExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import UIKit

// BOOL viewAppeared
// BOOL everAppeared

// navigationController
// 祖上的，就算 nav 包 tab，tab 里的 vc.nav 也能取到此
//
// tabBarController
// 祖上的，就算 tab 包 nav，nav 里的 vc.tab 也能取到此
//
// parent
// 直接父亲
//
// presentingViewController
// root present vc, root == vc.presenting == vc.sub.presenting == vc.sub.sub.presenting
// root present nav, root == nav.top.presenting == nav.top.sub.presenting == nav.top.sub.sub.presenting
// root present tab, root == tab.presenting == tab.vc.presenting == tab.vc.sub.presenting == tab.vc.sub.sub.presenting

// present 时，.fullScreen 样式会让父 vc 会收到 viewWillDisappear: 等事件，否则不算消失
// https://betterprogramming.pub/the-lifecycle-and-control-when-dismissing-a-modal-view-with-pagesheet-in-ios-13-4bbd1e3e1ec7
//
// .formSheet 样式时，下拖但不放手，会调用 viewWillDisappear-viewWillAppear-viewDidAppear

// receiver.dismiss(animated: true)
//   dismiss everything else to show receiver
//   dismiss receiver if no else

extension UIViewController {

  public var navPrev: UIViewController? {
    if let i = navigationController?.viewControllers.firstIndex(of: self),
      let vc = navigationController?.viewControllers.at(i - 1)
    {
      return vc
    }
    return nil
  }
  public var navNext: UIViewController? {
    if let i = navigationController?.viewControllers.firstIndex(of: self),
      let vc = navigationController?.viewControllers.at(i + 1)
    {
      return vc
    }
    return nil
  }

  public var canPopSelf: Bool {
    navPrev != nil
  }
  public func popSelf(_ animated: Bool, completion: (@Sendable () -> Void)?) {
    if let prev = navPrev {
      navigationController?.popToViewController(prev, animated: animated)
      if let completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + (animated ? 0.5 : 0.2), execute: completion)
      }
    } else {
      if let completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: completion)
      }
    }
  }
  public func popToSelf(_ animated: Bool, completion: (@Sendable () -> Void)?) {
    if navNext != nil {
      navigationController?.popToViewController(self, animated: animated)
      if let completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + (animated ? 0.5 : 0.2), execute: completion)
      }
    } else {
      if let completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: completion)
      }
    }
  }

  public var ancestorVc: UIViewController? {
    var ret = self
    while let vc = ret.parent {
      ret = vc
    }
    return ret
  }
  public var canDismissSelf: Bool {
    presentingViewController != nil
  }
  public func dismissSelf(_ animated: Bool, completion: (@Sendable () -> Void)?) {
    if let prev = presentingViewController {
      prev.dismiss(animated: animated, completion: completion)
      // if prev.presentedViewController?.modalPresentationStyle == .pageSheet { prev.invokeLifecycle(true) }
    } else {
      if let completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: completion)
      }
    }
  }
  public func dismissToSelf(_ animated: Bool, completion: (@Sendable () -> Void)?) {
    if let ancestor = ancestorVc, ancestor.presentedViewController != nil {
      ancestor.dismiss(animated: animated, completion: completion)
      // if next.modalPresentationStyle == .pageSheet { outmost.invokeLifecycle(true) }
    } else {
      if let completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: completion)
      }
    }
  }

  public func backSelf(_ animated: Bool, completion: (@Sendable () -> Void)?) {
    if navPrev != nil {
      popSelf(animated, completion: completion)
    } else {
      dismissSelf(animated, completion: completion)
    }
  }

  // func invokeLifecycle(_ appearing: Bool) {
  //   beginAppearanceTransition(appearing, animated: true)
  //   endAppearanceTransition()
  // }
}

extension UINavigationController {
  public func pop(_ count: Int, animated: Bool) {
    guard count >= 1 else { return }
    guard viewControllers.count >= 2 else { return }
    if count == 1 {
      popViewController(animated: animated)
    } else {
      let total = viewControllers.count
      if count >= total - 1 {
        popToRootViewController(animated: animated)
      } else {
        popToViewController(viewControllers[total - count - 1], animated: animated)
      }
    }
  }
}
