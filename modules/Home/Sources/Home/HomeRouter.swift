//
//  HomeRouter.swift
//  Home
//
//  Created by Kevin Wu on 2/15/26.
//

import UIKit

@MainActor
public struct HomeRouter {
  public static func createHomeVc() -> UIViewController {
    HomeViewController()
  }
}
