//
//  Theme.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit

public enum Theme: String {
  case day
  case night
  public var value: UIUserInterfaceStyle {
    switch self {
    case .day: .light
    case .night: .dark
    }
  }
}
