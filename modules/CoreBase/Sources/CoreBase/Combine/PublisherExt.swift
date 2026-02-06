//
//  PublisherExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/6/26.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
  public func toEvent(_ handler: @escaping (Output) -> Bool) -> AnyPublisher<Void, Never> {
    self.filter(handler)
      .map { _ in () }
      .eraseToAnyPublisher()
  }
}

extension Publisher {
  public func fallVal(_ handler: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
    self.map {
      handler($0)
      return $0
    }
    .eraseToAnyPublisher()
  }
  public func fallErr(_ handler: @escaping (Failure) -> Void) -> AnyPublisher<Output, Failure> {
    self.mapError {
      handler($0)
      return $0
    }
    .eraseToAnyPublisher()
  }
}

extension Subscribers.Completion {
  public var isFinished: Bool {
    if case .finished = self { true } else { false }
  }
  public var isFailure: Bool {
    if case .failure = self { true } else { false }
  }
}

extension Task {
  public func asCancellable() -> AnyCancellable {
    // .init { self.cancel() }
    AnyCancellable(cancel)
  }
  public func store(in set: inout Set<AnyCancellable>) {
    // set.insert(AnyCancellable(cancel))
    AnyCancellable(cancel).store(in: &set)
  }
}
