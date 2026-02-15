//
//  ControlEvent.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/8/26.
//

import UIKit
import Combine

extension UIButton {
  public var tap: AnyPublisher<Void, Never> {
    Publishers.ControlEvent(control: self, event: .touchUpInside)
      .eraseToAnyPublisher()
  }
}

extension Publishers {

  struct ControlEvent<Control: UIControl>: Publisher {
    typealias Output = Void
    typealias Failure = Never

    let control: Control
    let event: UIControl.Event

    // called when sink
    func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
      let sub = Sub(subscriber: subscriber, control: control, event: event)
      subscriber.receive(subscription: sub)
    }

    final class Sub<S: Subscriber, C: UIControl>: Subscription, @unchecked Sendable where S.Input == Void {
      init(subscriber: S, control: C, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        self.event = event
        Task { @MainActor in
          control.addTarget(self, action: #selector(handle), for: event)
        }
      }
      let subscriber: S
      let control: C
      let event: UIControl.Event

      // called after sink
      func request(_ demand: Subscribers.Demand) {
        // We don't care about the demand at this point.
        // As far as we're concerned - UIControl events are endless until the control is deallocated.
      }

      // called when cancellable deinit
      func cancel() {
        Task { @MainActor in
          control.removeTarget(self, action: #selector(handle), for: event)
        }
      }

      @objc func handle() {
        _ = subscriber.receive()
      }

      // deinit { Swift.print("control-event, deinit") }
    }
  }

}
