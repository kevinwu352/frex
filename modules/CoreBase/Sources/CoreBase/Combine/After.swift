//
//  After.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/6/26.
//

import Foundation
import Combine

// 如果某个属性既有 sink 又有 willSet/didSet 时，它们的执行顺序如下：
// out: will set
//  in: set before
//    sink: got: abc
//  in: set after
// out: did set
@propertyWrapper
public struct After<Output>: Publisher {
  public typealias Failure = Never

  let subject: CurrentValueSubject<Output, Never>

  public init(wrappedValue: Output) {
    subject = CurrentValueSubject<Output, Never>(wrappedValue)
  }

  public var wrappedValue: Output {
    get { subject.value }
    nonmutating set {
      // Swift.print("set before")
      subject.send(newValue)
      // Swift.print("set after")
    }
  }

  public var projectedValue: After<Output> { self }

  public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
    subject.receive(subscriber: subscriber)
  }
}
