//
//  CodecTests.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/6/26.
//

import Foundation
import Testing
@testable import CoreBase

struct CodecTests {

  @Test func parse() async throws {
    let str = """
      {"nn":null,"bb":true,"ii":100,"dd":1.2,"id1":1.0,"id2":10.0,"ss":"bob","aa":[1,2,null,3],"a1":[1,2,4.0,3],"a2":[1,2,4.2,3],"oo":{"b":2,"d":null,"c":3,"a":1},"o1":{"b":2,"d":4.0,"c":3,"a":1},"o2":{"b":2,"d":4.2,"c":3,"a":1}}
      """
    let json = try? jsonDecode(str.utf8dat)
    let map = jsonStandardize(json) as? [String: Any] ?? [:]

    let aa = map["aa"] as? [Int?]
    #expect(aa != nil)
    #expect(aa == [1, 2, nil, 3])
    let a1 = map["a1"]
    #expect((a1 as? [Int?]) == nil)
    #expect((a1 as? [Double?]) == nil)
    #expect((a1 as? [Any]) != nil)
    #expect((a1 as? [Any?]) != nil)
    let a2 = map["a2"]
    #expect((a2 as? [Int?]) == nil)
    #expect((a2 as? [Double?]) == nil)
    #expect((a2 as? [Any]) != nil)
    #expect((a2 as? [Any?]) != nil)

    let oo = map["oo"] as? [String: Int?]
    #expect(oo != nil)
    #expect(oo == ["a": 1, "c": 3, "d": nil, "b": 2])
    let o1 = map["o1"]
    #expect((o1 as? [String: Int?]) == nil)
    #expect((o1 as? [String: Double?]) == nil)
    #expect((o1 as? [String: Any]) != nil)
    #expect((o1 as? [String: Any?]) != nil)
    let o2 = map["o2"]
    #expect((o2 as? [String: Int?]) == nil)
    #expect((o2 as? [String: Double?]) == nil)
    #expect((o2 as? [String: Any]) != nil)
    #expect((o2 as? [String: Any?]) != nil)

    // 总结：不要在数组/字典里面混用 Int/Double，否则用 as? 转类型会失败
  }

  @Test func types() async throws {
    let str = """
      {"nn":null,"bb":true,"ii":100,"dd":1.2,"id1":1.0,"id2":10.0,"ss":"bob","aa":[1,2,null,3],"oo":{"b":2,"d":null,"c":3,"a":1}}
      """
    let map = (try? JSONSerialization.jsonObject(with: Data(str.utf8))) as? [String: Any] ?? [:]

    // null is NSNull
    #expect(map["nn"] is NSNull)
    #expect(map["nn"] as? NSNull == NSNull())
    #expect(map["nn"] as? NSNull === NSNull())
    // null is not NSNumber?/Bool?/Int?/Double?/String?
    #expect(!(map["nn"] is NSNumber?))
    #expect(!(map["nn"] is Bool?))
    #expect(!(map["nn"] is Int?))
    #expect(!(map["nn"] is Double?))
    #expect(!(map["nn"] is String?))
    #expect(map["nn"] as? NSNumber? == nil)
    #expect(map["nn"] as? Bool? == nil)
    #expect(map["nn"] as? Int? == nil)
    #expect(map["nn"] as? Double? == nil)
    #expect(map["nn"] as? String? == nil)

    // bool/int/double is NSNumber
    #expect(map["bb"] is NSNumber)
    #expect(map["ii"] is NSNumber)
    #expect(map["dd"] is NSNumber)
    #expect(map["id1"] is NSNumber)
    #expect(map["id2"] is NSNumber)
    #expect(map["bb"] as? NSNumber != nil)
    #expect(map["ii"] as? NSNumber != nil)
    #expect(map["dd"] as? NSNumber != nil)
    #expect(map["id1"] as? NSNumber != nil)
    #expect(map["id2"] as? NSNumber != nil)

    // bool is Bool/Int/Double
    #expect(map["bb"] is Bool)
    #expect(map["bb"] is Int)
    #expect(map["bb"] is Double)
    #expect(map["bb"] as? Bool != nil)
    #expect(map["bb"] as? Int != nil)
    #expect(map["bb"] as? Double != nil)
    // CFGetTypeID(int/double) != CFBooleanGetTypeID()
    #expect(CFGetTypeID(map["bb"] as? NSNumber) == CFBooleanGetTypeID())
    #expect(CFGetTypeID(map["ii"] as? NSNumber) != CFBooleanGetTypeID())
    #expect(CFGetTypeID(map["dd"] as? NSNumber) != CFBooleanGetTypeID())
    #expect(CFGetTypeID(map["id1"] as? NSNumber) != CFBooleanGetTypeID())
    #expect(CFGetTypeID(map["id2"] as? NSNumber) != CFBooleanGetTypeID())

    // 100 is Int/Double
    #expect(!(map["ii"] is Bool))
    #expect(map["ii"] is Int)
    #expect(map["ii"] is Double)
    #expect(map["ii"] as? Bool == nil)
    #expect(map["ii"] as? Int != nil)
    #expect(map["ii"] as? Double != nil)
    // 1.2 is Double
    #expect(!(map["dd"] is Bool))
    #expect(!(map["dd"] is Int))
    #expect(map["dd"] is Double)
    #expect(map["dd"] as? Bool == nil)
    #expect(map["dd"] as? Int == nil)
    #expect(map["dd"] as? Double != nil)
    // 1.0 is Bool/Int/Double
    #expect(map["id1"] is Bool)
    #expect(map["id1"] is Int)
    #expect(map["id1"] is Double)
    #expect(map["id1"] as? Bool != nil)
    #expect(map["id1"] as? Int != nil)
    #expect(map["id1"] as? Double != nil)
    // 10.0 is Int/Double
    #expect(!(map["id2"] is Bool))
    #expect(map["id2"] is Int)
    #expect(map["id2"] is Double)
    #expect(map["id2"] as? Bool == nil)
    #expect(map["id2"] as? Int != nil)
    #expect(map["id2"] as? Double != nil)
    // CFNumberType.charType / CFNumberType.sInt64Type / CFNumberType.float64Type
    #expect(CFNumberGetType(map["bb"] as? NSNumber).rawValue == CFNumberType.charType.rawValue)
    #expect(CFNumberGetType(map["ii"] as? NSNumber).rawValue == CFNumberType.sInt64Type.rawValue)
    #expect(CFNumberGetType(map["dd"] as? NSNumber).rawValue == CFNumberType.float64Type.rawValue)
    #expect(CFNumberGetType(map["id1"] as? NSNumber).rawValue == CFNumberType.float64Type.rawValue)
    #expect(CFNumberGetType(map["id2"] as? NSNumber).rawValue == CFNumberType.float64Type.rawValue)
    #expect([CFNumberType.sInt8Type, .sInt16Type, .sInt32Type, .sInt64Type, .intType, .longType, .longLongType, .charType, .shortType, .nsIntegerType].contains(CFNumberGetType(map["ii"] as? NSNumber)))
    #expect([CFNumberType.floatType, .float32Type, .float64Type, .doubleType, .cgFloatType].contains(CFNumberGetType(map["dd"] as? NSNumber)))
    #expect([CFNumberType.floatType, .float32Type, .float64Type, .doubleType, .cgFloatType].contains(CFNumberGetType(map["id1"] as? NSNumber)))
    #expect([CFNumberType.floatType, .float32Type, .float64Type, .doubleType, .cgFloatType].contains(CFNumberGetType(map["id2"] as? NSNumber)))
  }

}
