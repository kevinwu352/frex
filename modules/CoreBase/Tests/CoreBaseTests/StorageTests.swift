//
//  StorageTests.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/11/26.
//

import Foundation
import Testing
@testable import CoreBase

struct StorageTests {

  struct User: Equatable, Codable {
    let name: String
    let age: Int
  }

  @Test func basic() async throws {
    let storage = Storage("")

    #expect(storage.bool(forKey: "bb") == nil)
    storage.setBool(true, forKey: "bb")
    #expect(storage.bool(forKey: "bb") == true)

    #expect(storage.int(forKey: "ii") == nil)
    storage.setInt(100, forKey: "ii")
    #expect(storage.int(forKey: "ii") == 100)

    #expect(storage.double(forKey: "dd") == nil)
    storage.setDouble(1.23, forKey: "dd")
    #expect(storage.double(forKey: "dd") == 1.23)

    #expect(storage.string(forKey: "ss") == nil)
    storage.setString("asdf", forKey: "ss")
    #expect(storage.string(forKey: "ss") == "asdf")

    let date1 = storage.date(forKey: "date")
    #expect(date1 == nil)
    let date2 = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 60 * 30)
    print(date2)
    storage.setDate(date2, forKey: "date")
    let date3 = storage.date(forKey: "date")
    if let date3 { print(date3) }
    #expect(date2 == date3)

    let aa1: [Int]? = storage.codable(forKey: "aa")
    #expect(aa1 == nil)
    let aa2 = [1, 2, 3]
    storage.setCodable(aa2, forKey: "aa")
    let aa3: [Int]? = storage.codable(forKey: "aa")
    if let aa3 { print(aa3) }
    #expect(aa2 == aa3)

    let oo1: [String: Int]? = storage.codable(forKey: "oo")
    #expect(oo1 == nil)
    let oo2 = ["kk": 10]
    storage.setCodable(oo2, forKey: "oo")
    let oo3: [String: Int]? = storage.codable(forKey: "oo")
    if let oo3 { print(oo3) }
    #expect(oo2 == oo3)

    let object1: User? = storage.codable(forKey: "codable")
    #expect(object1 == nil)
    let object2 = User(name: "kevin", age: 18)
    storage.setCodable(object2, forKey: "codable")
    let object3: User? = storage.codable(forKey: "codable")
    #expect(object2 == object3)
  }

}
