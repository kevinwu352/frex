//
//  LoginViewModel.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel {
  var bag = Set<AnyCancellable>()

  let repo: LoginRepo
  init(repo: LoginRepo) {
    self.repo = repo
    print("login-vm, init")
  }
  deinit { print("login-vm, deinit") }

  func login(_ id: Int) {
    Task { [weak self] in
      print("login-vm, do login")
      let user = try? await self?.repo.login(id)
      if let user {
        await self?.repo.saveUser(user)
      }
    }
    .store(in: &bag)
  }

}
