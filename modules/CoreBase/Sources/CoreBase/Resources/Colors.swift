//
//  Colors.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit

extension ColorResource {
  public static let kViewBg11 = ColorResource.viewBg
  public static let kTextPrimary11 = ColorResource.textPrimary
}

extension UIColor {
  public static let kViewBg = UIColor(resource: .viewBg)
  public static let kTextPrimary = UIColor(resource: .textPrimary)
}
