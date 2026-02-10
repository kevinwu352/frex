//
//  Storage.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/10/26.
//

import Foundation

public final class Storage: @unchecked Sendable {

  public let path: String

  public private(set) var map: [String: Any] {
    didSet {
      guard !path.isEmpty else { return }
      work = DispatchWorkItem { [weak self] in
        guard let self else { return }
        do {
          let data = try jsonEncode(self.map, options: .prettyPrinted)
          try dataWrite(self.path, data: data)
          print("storage, synchronize success, \(self.path)")
        } catch {
          print("storage, synchronize failed, \(self.path)")
        }
      }
      queue.async(execute: work!)
    }
  }
  private var work: DispatchWorkItem? {
    didSet { oldValue?.cancel() }
  }

  private let queue: DispatchQueue

  public init(_ path: String) {
    self.path = path
    do {
      let data = try dataRead(path)
      map = try jsonDecode(data) as? [String: Any] ?? [:]
      print("storage, load success, \(path)")
    } catch {
      print("storage, load failed, \(path)")
      map = [:]
    }
    queue = DispatchQueue(label: "queue-storage-\(UUID().uuidString.lowercased())", attributes: .concurrent)
  }

  deinit { print("storage, deinit, \(path)") }
}

extension Storage {
  public func getBool(_ key: String) -> Bool? {
    queue.sync { map[key] as? Bool }
  }
  public func setBool(_ value: Bool?, _ key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func getInt(_ key: String) -> Int? {
    queue.sync { map[key] as? Int }
  }
  public func setInt(_ value: Int?, _ key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func getDouble(_ key: String) -> Double? {
    queue.sync { map[key] as? Double }
  }
  public func setDouble(_ value: Double?, _ key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func getString(_ key: String) -> String? {
    queue.sync { map[key] as? String }
  }
  public func setString(_ value: String?, _ key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

//  public func getDate(_ key: String) -> Date? {
//    queue.sync {
//      guard let time = map[key] as? TimeInterval else { return nil }
//      return Date(timeIntervalSince1970: time)
//    }
//  }
//  public func setDate(_ value: Date?, _ key: String) {
//    queue.async(flags: .barrier) { self.map[key] = value?.timeIntervalSince1970 }
//  }

//  public func getObject<T: Decodable>(_ key: String) -> T? {
//    queue.sync {
//      do {
//        guard let data = try jsonEncode(map[key]) else { return nil }
//        return try JSONDecoder().decode(T.self, from: data)
//      } catch {
//        return nil
//      }
//    }
//  }
//  public func setObject<T: Encodable & Sendable>(_ value: T?, _ key: String) {
//    queue.async(flags: .barrier) {
//      do {
//        guard let value else { return }
//        let data = try JSONEncoder().encode(value)
//        let json = try jsonDecode(data)
//        self.map[key] = json
//      } catch {
//        self.map[key] = nil
//      }
//    }
//  }
}

extension Storage {
  public var name: String? {
    get { getString("nnn") }
    set { setString(newValue, "nnn") }
  }
  public var age: Int? {
    get { getInt("aaa") }
    set { setInt(newValue, "aaa") }
  }
}
