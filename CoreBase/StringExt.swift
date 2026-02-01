//
//  StringExt.swift
//  frex
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation

// Data - String
public extension Data {
  var utf8str: String { String(decoding: self, as: UTF8.self) }
}
public extension String {
  var utf8dat: Data { Data(utf8) }
}

// HexData - String
public extension Data {
  var hexstr: String {
    map { String(format: "%02x", $0) }
      .joined(separator: "")
  }
}
public extension String {
  var hexdat: Data? {
    assert(count%2 == 0, "`count` should not be odd")
    var data = Data()
    for i in 0..<count/2 {
      let beg = index(startIndex, offsetBy: i*2)
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
