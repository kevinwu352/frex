//
//  Codec.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import Foundation

public func pathmk(_ trail: String, _ uid: String?, _ dir: FileManager.SearchPathDirectory = .documentDirectory) -> String {
  let base = NSSearchPathForDirectoriesInDomains(dir, .userDomainMask, true).first ?? ""
  if let uid, !uid.isEmpty {
    return base.addedPathSeg(["Users", uid].joined(separator: "/")).addedPathSeg(trail)
  } else {
    return base.addedPathSeg(trail)
  }
}
extension String {
  public func addedPathSeg(_ seg: String) -> String {
    guard !seg.isEmpty else { return self }
    if hasSuffix("/") && seg.hasPrefix("/") {
      return self + seg.dropFirst()
    } else if !hasSuffix("/") && !seg.hasPrefix("/") {
      return self + "/" + seg
    } else {
      return self + seg
    }
  }
}
