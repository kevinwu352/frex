//
//  LoginSwitcher.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation
import Combine
import Factory

extension Container {
  public var switcher: Factory<LoginSwitcher> {
    self { @MainActor in LoginSwitcher() }.cached
  }
}

@MainActor
public final class LoginSwitcher {
  let defaults = Container.shared.defaults()
  let secures = Container.shared.secures()

  init() {
    print("switcher, init")
    loadSavedUser()
  }
  deinit { print("switcher, deinit") }

  @Published var object: User?

  public var user: User? {
    object
  }
  public var userPub: AnyPublisher<User?, Never> {
    $object.eraseToAnyPublisher()
  }

  func loadSavedUser() {
    if let username = defaults.lastUsername, !username.isEmpty,
       let token = secures.accessToken, !token.isEmpty
    {
      let user = User.load(username: username, token: token)
      object = user
    }
  }
  public func loggedIn(_ user: User) {
    if !user.username.isEmpty && !user.token.isEmpty {
      defaults.lastUsername = user.username
      secures.accessToken = user.token
      user.save()
      object = user
    }
  }
  public func loggedOut() {
    defaults.lastUsername = nil
    secures.accessToken = nil
    object = nil
  }

}
