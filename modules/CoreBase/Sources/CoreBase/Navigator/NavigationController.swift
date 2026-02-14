//
//  NavigationController.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit

public class NavigationController: UINavigationController {

  public override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

}

extension NavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if interactivePopGestureRecognizer != nil {
      // return false
    }
    return true
  }
}
