//
//  Codec.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import Foundation

public func pathmk(_ trail: String, uid: String = "") -> String {
  (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "")
    .addedPathSeg(uid.isEmpty ? "" : ["Users", uid].joined(separator: "/"))
    .addedPathSeg(trail)
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

// TODO: try?
// TODO: 第二参数的名字
public func path_create_dir(_ path: String?) {
  guard let path, !path.isEmpty else { return }
  if !FileManager.default.fileExists(atPath: path, isDirectory: nil) {
    try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
  }
}
public func path_create_file(_ path: String?) {
  guard let path, !path.isEmpty else { return }
  let dir = (path as NSString).deletingLastPathComponent
  if !FileManager.default.fileExists(atPath: dir, isDirectory: nil) {
    try? FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
  }
  if !FileManager.default.fileExists(atPath: path, isDirectory: nil) {
    FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
  }
}
public func path_delete(_ path: String?) {
  guard let path, !path.isEmpty else { return }
  try? FileManager.default.removeItem(atPath: path)
}

// null
// bool/int/double
// string
// array
// object
public func data_read(_ path: String?) -> Data? {
  guard let path, !path.isEmpty else { return nil }
  return try? Data(contentsOf: URL(fileURLWithPath: path))
}
public func data_write(_ path: String?, data: Data?) {
  guard let path, !path.isEmpty else { return }
  let dir = (path as NSString).deletingLastPathComponent
  if !FileManager.default.fileExists(atPath: dir, isDirectory: nil) {
    try? FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
  }
  try? data?.write(to: URL(fileURLWithPath: path))
}

public func json_encode(_ json: Any?, options: JSONSerialization.WritingOptions = []) -> Data? {
  if let json, JSONSerialization.isValidJSONObject(json) {
    return try? JSONSerialization.data(withJSONObject: json, options: options)
  } else {
    return nil
  }
}
public func json_decode(_ data: Data?, options: JSONSerialization.ReadingOptions = []) -> Any? {
  if let data, !data.isEmpty {
    return json_standardize(try? JSONSerialization.jsonObject(with: data, options: options))
  } else {
    return nil
  }
}
public func json_standardize(_ json: Any?) -> Any? {
  if let array = json as? [Any] {
    return array.compactMap { json_standardize($0) }
  } else if let object = json as? [String: Any] {
    return object.compactMapValues { json_standardize($0) }
  } else if let number = json as? NSNumber {
    if number.isBool {
      return json as? Bool
    } else if number.isInt {
      return json as? Int
    } else if number.isDouble {
      return json as? Double
    }
  } else if let string = json as? String {
    return string
  }
  return nil
}
// bool as NSNumber   : is bool/int
// int as NSNumber    : is int
// double as NSNumber : is double
extension NSNumber {
  fileprivate var isBool: Bool {
    CFGetTypeID(self) == CFBooleanGetTypeID()
  }
  fileprivate var isInt: Bool {
    [
      CFNumberType.sInt8Type,
      CFNumberType.sInt16Type,
      CFNumberType.sInt32Type,
      CFNumberType.sInt64Type,
      CFNumberType.intType,
      CFNumberType.longType,
      CFNumberType.longLongType,
      CFNumberType.nsIntegerType,
      CFNumberType.charType,
      CFNumberType.shortType,
    ].contains(CFNumberGetType(self))
  }
  fileprivate var isDouble: Bool {
    [
      CFNumberType.float32Type,
      CFNumberType.float64Type,
      CFNumberType.floatType,
      CFNumberType.doubleType,
      CFNumberType.cgFloatType,
    ].contains(CFNumberGetType(self))
  }
}
