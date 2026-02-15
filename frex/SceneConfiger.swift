//
//  SceneConfiger.swift
//  frex
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation
import Combine
import CoreBase
import Factory
import Auth

@MainActor
final class SceneConfiger {

  lazy var bag = Set<AnyCancellable>()

  let defaults = Container.shared.defaults()
  let switcher = Container.shared.switcher()

  init() {
    loadShowOnboard()
    loadLogined()
    bindEvents()
  }

  func bindEvents() {
    defaults.$boardedVersion
      .sink { [weak self] _ in
        guard let self else { return }
        self.resetOnboard()
      }
      .store(in: &bag)

    switcher.userPub
      .sink { [weak self] user in
        guard let self else { return }
        let logined = user != nil
        if logined != self.logined {
          print("logined:\(logined), \(String(describing: user))")
          self.resetEnvs(user)
          self.logined = logined
        } else {
          print("logined:\(logined), not change, return")
        }
      }
      .store(in: &bag)
  }

  @Published var showOnboard = false
  func loadShowOnboard() {
    resetOnboard()
  }
  func resetOnboard() {
    guard let current = Bundle.main.versionNumber else { return }
    if let boarded = defaults.boardedVersion {
      showOnboard = current.compare(boarded, options: .numeric) == .orderedDescending
    } else {
      showOnboard = true
    }
  }

  @Published var logined = false
  func loadLogined() {
    resetEnvs(switcher.user)
    logined = switcher.user != nil
  }
  func resetEnvs(_ user: User?) {
    if let user {
      Container.shared.options.register { @MainActor in UserOptions(uid: user.username, persist: true) }
      Container.shared.network.register { HTTPClient(token: user.token) }
      Container.shared.usermg.register { @MainActor in AuthRouter.createUserManager(user) }
    } else {
      Container.shared.options.reset(.registration)
      Container.shared.network.reset(.registration)
      Container.shared.usermg.reset(.registration)
    }
    Container.shared.manager.reset(scope: .session)
  }

}
