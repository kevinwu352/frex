//
//  StringExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation

// Double(10) / Int(1.2)
// String(10) / Int("10")
// String(format: "%f", 1.2) / Double("1.2")

// Data - String
extension Data {
  public var utf8str: String { String(data: self, encoding: .utf8) ?? "" }
}
extension String {
  public var utf8dat: Data { Data(utf8) }
}

// HexData - String
extension Data {
  public var hexstr: String {
    map { String(format: "%02x", $0) }
      .joined(separator: "")
  }
}
extension String {
  public var hexdat: Data? {
    assert(count % 2 == 0, "`count` should not be odd")
    var data = Data()
    for i in 0..<count / 2 {
      let beg = index(startIndex, offsetBy: i * 2)
      let end = index(beg, offsetBy: 2)
      let byte = self[beg..<end]
      if var num = UInt8(byte, radix: 16) {
        data.append(&num, count: 1)
      } else {
        return nil
      }
    }
    return data
  }
}

// TODO: add more if needed
