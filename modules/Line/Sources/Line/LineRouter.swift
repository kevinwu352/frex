//
//  LineRouter.swift
//  Line
//
//  Created by Kevin Wu on 2/15/26.
//

import UIKit

@MainActor
public struct LineRouter {
  public static func createLineVc() -> UIViewController {
    LineViewController()
  }
}
