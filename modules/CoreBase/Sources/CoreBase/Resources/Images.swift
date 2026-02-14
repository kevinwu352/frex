//
//  Images.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit

// 导出 UIImage/ImageResource 都行，但我决定直接导出前者
extension UIImage {
  public static let kFiatCloud = UIImage(resource: .fiatCloud)
  public static let kRipeTomato = UIImage(resource: .ripeTomato)
}

extension ImageResource {
  public static let kFiatCloud11 = ImageResource.fiatCloud
  public static let kRipeTomato11 = ImageResource.ripeTomato
}
