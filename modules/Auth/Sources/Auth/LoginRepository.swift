//
//  LoginRepository.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import CoreBase
import Factory
import Foundation

protocol LoginRepo: Sendable {
  func login(_ id: Int) async throws -> User?
  func saveUser(_ user: User) async
}

final class LoginRepository: LoginRepo {
  let switcher = Container.shared.switcher()
  let network = Container.shared.network()

  func login(_ id: Int) async throws -> User? {
    let list = try await network.request(Api.login(), type: Users.self)
    if let user = list.first(where: { $0.id == id }) {
      return user
    }
    return nil
  }

  func saveUser(_ user: User) async {
    await switcher.didLogin(user)
  }
}
