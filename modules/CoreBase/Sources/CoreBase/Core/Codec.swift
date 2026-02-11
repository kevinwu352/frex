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
public func pathCreateDir(_ path: String?) throws {
  guard let path, !path.isEmpty else { throw URLError(.fileDoesNotExist) }
  if !FileManager.default.fileExists(atPath: path, isDirectory: nil) {
    try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
  }
}
public func pathCreateFile(_ path: String?) throws {
  guard let path, !path.isEmpty else { throw URLError(.fileDoesNotExist) }
  let dir = (path as NSString).deletingLastPathComponent
  if !FileManager.default.fileExists(atPath: dir, isDirectory: nil) {
    try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
  }
  if !FileManager.default.fileExists(atPath: path, isDirectory: nil) {
    FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
  }
}
public func pathDelete(_ path: String?) throws {
  guard let path, !path.isEmpty else { throw URLError(.fileDoesNotExist) }
  try FileManager.default.removeItem(atPath: path)
}

public func dataRead(_ path: String?) throws -> Data {
  guard let path, !path.isEmpty else { throw URLError(.fileDoesNotExist) }
  return try Data(contentsOf: URL(fileURLWithPath: path))
}
public func dataWrite(_ path: String?, data: Data?) throws {
  guard let path, !path.isEmpty else { throw URLError(.fileDoesNotExist) }
  let dir = (path as NSString).deletingLastPathComponent
  if !FileManager.default.fileExists(atPath: dir, isDirectory: nil) {
    try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
  }
  try data?.write(to: URL(fileURLWithPath: path))
}

// null
// bool/int/double
// string
// array
// object
public func jsonEncode(_ json: Any?, options: JSONSerialization.WritingOptions = []) throws -> Data {
  // return true only when json is array/object
  guard let json, JSONSerialization.isValidJSONObject(json) else { throw URLError(.cannotParseResponse) }
  return try JSONSerialization.data(withJSONObject: json, options: options)
}
public func jsonDecode(_ data: Data?, options: JSONSerialization.ReadingOptions = []) throws -> Any {
  guard let data, !data.isEmpty else { throw URLError(.zeroByteResource) }
  // success only when data represents array/object
  return try JSONSerialization.jsonObject(with: data, options: options)
  // return jsonStandardize(try JSONSerialization.jsonObject(with: data, options: options)) as Any
}
public func jsonStandardize(_ json: Any?) -> Any? {
  if json is NSNull {
    return nil
  } else if let array = json as? [Any] {
    return array.map { jsonStandardize($0) }
  } else if let object = json as? [String: Any] {
    return object.mapValues { jsonStandardize($0) }
  } else if let number = json as? NSNumber {
    if CFGetTypeID(number) == CFBooleanGetTypeID() {
      return json as? Bool
    } else if [
      CFNumberType.sInt8Type, .sInt16Type, .sInt32Type, .sInt64Type,
      .intType, .longType, .longLongType,
      .charType, .shortType, .nsIntegerType,
    ].contains(CFNumberGetType(number)) {
      return json as? Int
    } else if [
      CFNumberType.float32Type, .float64Type,
      .floatType, .doubleType,
      .cgFloatType,
    ].contains(CFNumberGetType(number)) {
      return json as? Double
    }
  } else if let string = json as? String {
    return string
  }
  return nil
}
