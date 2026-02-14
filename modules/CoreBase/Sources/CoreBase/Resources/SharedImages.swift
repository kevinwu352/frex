//
//  SharedImages.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit

// 导出 UIImage/ImageResource 都行，但我决定直接导出前者
extension UIImage {
  public static let kFlatCloud = UIImage(resource: .flatCloud)
  public static let kRipeTomato = UIImage(resource: .ripeTomato)
}

extension ImageResource {
  public static let kFlatCloud11 = ImageResource.flatCloud
  public static let kRipeTomato11 = ImageResource.ripeTomato
}

// 外面的包能用 cur，且业务包里面，能用 cur 取到业务包内部自己的图片
// 可见 ImageResource 里的东西虽然可能是自己包私有的，但是 ImageResource 这个类应该是大家公用的
// 不知为何，我感觉还是不要用这东西，还是直接用 UIImage(resource: .xxx) 吧，虽然麻烦一点点
// extension ImageResource {
//   public var cur: UIImage {
//     UIImage(resource: self)
//   }
// }
