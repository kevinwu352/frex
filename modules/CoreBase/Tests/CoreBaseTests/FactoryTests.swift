//
//  FactoryTests.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import Testing
@testable import CoreBase
import Factory

extension Container {
  var myService: Factory<MyService> {
    self { MyService(value: "aaa") }.cached
  }
  var cachedService: Factory<MyService> {
    self { MyService(value: "aaa") }.cached
  }
  var sessionService: Factory<MyService> {
    self { MyService(value: "aaa") }.scope(.session)
  }
}
class MyService: CustomStringConvertible {
  let value: String
  init(value: String) {
    print("init service")
    self.value = value
  }
  deinit {
    print("deinit service")
  }
  var description: String {
    "MyService:\(value)"
  }
}

struct FactoryTests {

  @Test func resolve() async throws {
    print("begin 111")
    let s1 = Container.shared.myService()
    let addr1 = String(describing: Unmanaged.passUnretained(s1).toOpaque())
    print(addr1 + " " + s1.value)
    #expect(s1.value == "aaa", "value should be 'aaa'")

    let s2 = Container.shared.myService()
    let addr2 = String(describing: Unmanaged.passUnretained(s2).toOpaque())
    print(addr2 + " " + s2.value)
    #expect(s2.value == "aaa", "value should be 'aaa'")

    #expect(addr1 == addr2, "addr should be equal")
    print("end 111")
  }

  @Test func reset() async throws {
    print("begin 222")
    let s1 = Container.shared.sessionService()
    let addr1 = String(describing: Unmanaged.passUnretained(s1).toOpaque())
    print(addr1 + " " + s1.value)
    #expect(s1.value == "aaa", "value should be 'aaa'")

    Container.shared.manager.reset(scope: .session)

    let s2 = Container.shared.sessionService()
    let addr2 = String(describing: Unmanaged.passUnretained(s2).toOpaque())
    print(addr2 + " " + s2.value)
    #expect(s2.value == "aaa", "value should be 'aaa'")

    #expect(addr1 != addr2, "addr should not be equal")
    print("end 222")
  }

  @Test func register() async throws {
    print("begin 333")
    let s1 = Container.shared.cachedService()
    let addr1 = String(describing: Unmanaged.passUnretained(s1).toOpaque())
    print(addr1 + " " + s1.value)
    #expect(s1.value == "aaa", "value should be 'aaa'")

    // 注册新的创建闭包，且清除缓存的实例，s2 会拿到新闭包创建的实例
    Container.shared.cachedService.register { MyService(value: "bbb") }

    let s2 = Container.shared.cachedService()
    let addr2 = String(describing: Unmanaged.passUnretained(s2).toOpaque())
    print(addr2 + " " + s2.value)
    #expect(s2.value == "bbb", "value should be 'bbb'")

    #expect(addr1 != addr2, "addr should not be equal")

    // 清除 新注册的闭包，但缓存还在，s3 拿到的实例和 s2 是同一个
    Container.shared.cachedService.reset(.registration)

    let s3 = Container.shared.cachedService()
    let addr3 = String(describing: Unmanaged.passUnretained(s3).toOpaque())
    print(addr3 + " " + s3.value)
    #expect(s3.value == "bbb", "value should be 'bbb'")

    #expect(addr2 == addr3, "addr should be equal")

    // 清除 新注册的实例，s4 拿到的是旧闭包创建的新实例
    Container.shared.cachedService.reset(.scope)

    let s4 = Container.shared.cachedService()
    let addr4 = String(describing: Unmanaged.passUnretained(s4).toOpaque())
    print(addr4 + " " + s4.value)
    #expect(s4.value == "aaa", "value should be 'aaa'")

    #expect(addr1 != addr4, "addr should not be equal")
    #expect(addr3 != addr4, "addr should not be equal")
    print("end 333")
  }

}
