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
          print("storage, synchronize success, \((self.path as NSString).lastPathComponent)")
        } catch {
          print("storage, synchronize failed, \((self.path as NSString).lastPathComponent)")
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
      let json = try jsonDecode(data)
      map = jsonStandardize(json) as? [String: Any] ?? [:]
      print("storage, load success, \((path as NSString).lastPathComponent)")
    } catch {
      print("storage, load failed, \((path as NSString).lastPathComponent)")
      map = [:]
    }
    queue = DispatchQueue(label: "queue-storage-\(UUID().uuidString.lowercased())", attributes: .concurrent)
  }

  deinit { print("storage, deinit, \((path as NSString).lastPathComponent)") }
}

extension Storage { // LABEL
  public func bool(forKey key: String) -> Bool? {
    queue.sync { map[key] as? Bool }
  }
  public func setBool(_ value: Bool?, forKey key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func int(forKey key: String) -> Int? {
    queue.sync { map[key] as? Int }
  }
  public func setInt(_ value: Int?, forKey key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func double(forKey key: String) -> Double? {
    queue.sync { map[key] as? Double }
  }
  public func setDouble(_ value: Double?, forKey key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func string(forKey key: String) -> String? {
    queue.sync { map[key] as? String }
  }
  public func setString(_ value: String?, forKey key: String) {
    queue.async(flags: .barrier) { self.map[key] = value }
  }

  public func date(forKey key: String) -> Date? {
    queue.sync {
      guard let time = map[key] as? TimeInterval else { return nil }
      let ret = Date(timeIntervalSince1970: time)
      return ret
    }
  }
  public func setDate(_ value: Date?, forKey key: String) {
    queue.async(flags: .barrier) { self.map[key] = value?.timeIntervalSince1970 }
  }

  public func object<T: Decodable>(forKey key: String) -> T? {
    queue.sync {
      do {
        let data = try jsonEncode(map[key])
        let ret = try JSONDecoder().decode(T.self, from: data)
        return ret
      } catch {
        return nil
      }
    }
  }
  public func setObject<T: Encodable & Sendable>(_ value: T?, forKey key: String) {
    queue.async(flags: .barrier) {
      do {
        guard let value else { throw URLError(.zeroByteResource) }
        let data = try JSONEncoder().encode(value)
        let json = try jsonDecode(data)
        self.map[key] = jsonStandardize(json)
      } catch {
        self.map[key] = nil
      }
    }
  }
}

extension Storage {
  public var name: String? {
    get { string(forKey: "nnn") }
    set { setString(newValue, forKey: "nnn") }
  }
  public var age: Int? {
    get { int(forKey: "aaa") }
    set { setInt(newValue, forKey: "aaa") }
  }
}
