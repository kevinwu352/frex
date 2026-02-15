//
//  ControlProperty.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/8/26.
//

import UIKit
import Combine

extension UITextField {
  public var txt: AnyPublisher<String?, Never> {
    Publishers.ControlProperty(control: self, event: [.editingChanged, .editingDidEnd, .editingDidEndOnExit], keyPath: \.text)
    .eraseToAnyPublisher()
  }
}

extension Publishers {

  struct ControlProperty<Control: UIControl, Value>: Publisher {
    typealias Output = Value
    typealias Failure = Never

    let control: Control
    let event: UIControl.Event
    let keyPath: KeyPath<Control, Value>

    func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
      let subscription = Sub(subscriber: subscriber, control: control, event: event, keyPath: keyPath)
      subscriber.receive(subscription: subscription)
    }

    final class Sub<S: Subscriber, C: UIControl, V>: Subscription, @unchecked Sendable where S.Input == V {
      init(subscriber: S, control: C, event: UIControl.Event, keyPath: KeyPath<C, V>) {
        self.subscriber = subscriber
        self.control = control
        self.event = event
        self.keyPath = keyPath
        Task { @MainActor in
          control.addTarget(self, action: #selector(handle), for: event)
        }
      }
      let subscriber: S
      let control: C
      let event: UIControl.Event
      let keyPath: KeyPath<C, V>

      func request(_ demand: Subscribers.Demand) {
        // Emit initial value upon first demand request
        if demand > .none {
          if !initialEmitted {
            initialEmitted = true
            _ = subscriber.receive(control[keyPath: keyPath])
          }
        }
      }
      var initialEmitted = false

      func cancel() {
        Task { @MainActor in
          control.removeTarget(self, action: #selector(handle), for: event)
        }
      }

      @objc func handle() {
        _ = subscriber.receive(control[keyPath: keyPath])
      }

      // deinit { Swift.print("ControlProperty, deinit") }
    }
  }

}
