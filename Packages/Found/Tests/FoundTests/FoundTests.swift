import Testing
@testable import Found
import Factory

public extension Container {
  var cachedObj: Factory<MyService> {
    self { MyService(value: "aaa") }.cached
  }
  var sessionObj: Factory<MyService> {
    self { MyService(value: "aaa") }.scope(.sess)
  }
}
public final class MyService {
  let value: String
  init(value: String) {
    print("init")
    self.value = value
  }
  deinit {
    print("deinit")
  }
}

@Test func testInFound1() async throws {
  let s1 = Container.shared.cachedObj()
  let addr1 = String(describing: Unmanaged.passUnretained(s1).toOpaque())
  print(addr1 + " " + s1.value)

  let s2 = Container.shared.cachedObj()
  let addr2 = String(describing: Unmanaged.passUnretained(s2).toOpaque())
  print(addr2 + " " + s2.value)

  #expect(addr1 == addr2, "addr should be equal")
  #expect(s1.value == "aaa", "value should be 'aaa'")
  #expect(s2.value == "aaa", "value should be 'aaa'")
}

@Test func testInFound2() async throws {
  let s1 = Container.shared.sessionObj()
  let addr1 = String(describing: Unmanaged.passUnretained(s1).toOpaque())
  print(addr1 + " " + s1.value)

  Container.shared.manager.reset(scope: .sess)

  let s2 = Container.shared.sessionObj()
  let addr2 = String(describing: Unmanaged.passUnretained(s2).toOpaque())
  print(addr2 + " " + s2.value)

  #expect(addr1 != addr2, "addr should not be equal")
  #expect(s1.value == "aaa", "value should be 'aaa'")
  #expect(s2.value == "aaa", "value should be 'aaa'")
}

@Test func testInFound3() async throws {
  let s1 = Container.shared.cachedObj()
  let addr1 = String(describing: Unmanaged.passUnretained(s1).toOpaque())
  print(addr1 + " " + s1.value)

  // 注册新的创建闭包，且清除缓存的实例，s2 会拿到新闭包创建的实例
  Container.shared.cachedObj.register { MyService(value: "bbb") }

  let s2 = Container.shared.cachedObj()
  let addr2 = String(describing: Unmanaged.passUnretained(s2).toOpaque())
  print(addr2 + " " + s2.value)

  #expect(addr1 != addr2, "addr should not be equal")
  #expect(s1.value == "aaa", "value should be 'aaa'")
  #expect(s2.value == "bbb", "value should be 'bbb'")

  // 清除 新注册的闭包，但缓存还在，s3 拿到的实例和 s2 是同一个
  Container.shared.cachedObj.reset(.registration)

  let s3 = Container.shared.cachedObj()
  let addr3 = String(describing: Unmanaged.passUnretained(s3).toOpaque())
  print(addr3 + " " + s3.value)

  #expect(addr2 == addr3, "addr should be equal")
  #expect(s3.value == "bbb", "value should be 'bbb'")

  // 清除 新注册的实例，s4 拿到的是旧闭包创建的新实例
  Container.shared.cachedObj.reset(.scope)

  let s4 = Container.shared.cachedObj()
  let addr4 = String(describing: Unmanaged.passUnretained(s4).toOpaque())
  print(addr4 + " " + s4.value)

  #expect(addr1 != addr4, "addr should not be equal")
  #expect(addr3 != addr4, "addr should not be equal")
  #expect(s4.value == "aaa", "value should be 'aaa'")
}
