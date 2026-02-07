//
//  UIColorExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import UIKit

// public func hex2f(_ value: UInt) {
//   let r = String(format: "%.5g", Double(value >> 16 & 0xff) / 255)
//   let g = String(format: "%.5g", Double(value >> 8 & 0xff) / 255)
//   let b = String(format: "%.5g", Double(value & 0xff) / 255)
//   let s = String(value, radix: 16, uppercase: false)
//   print("UIColor(red: \(r), green: \(g), blue: \(b), alpha: 1)  /* 0x\(s) */")
// }

extension UIColor {

  public convenience init(hex: UInt, alpha: Double = 1.0) {
    self.init(
      red: CGFloat(hex >> 16 & 0xff) / 255,
      green: CGFloat(hex >> 8 & 0xff) / 255,
      blue: CGFloat(hex & 0xff) / 255,
      alpha: alpha
    )
  }
  public static var random: UIColor {
    UIColor(
      red: .random(in: 0..<1),
      green: .random(in: 0..<1),
      blue: .random(in: 0..<1),
      alpha: 1
    )
  }

  // image.scale = screen scale
  public var img: UIImage {
    UIGraphicsImageRenderer(size: CGSize(width: 8, height: 8)).image {
      setFill()
      $0.fill($0.format.bounds)
    }
  }

}
