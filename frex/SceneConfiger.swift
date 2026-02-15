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

@MainActor
final class SceneConfiger {

  lazy var bag = Set<AnyCancellable>()

  let defaults = Container.shared.defaults()
  let switcher = Container.shared.switcher()

  init() {
    loadShowOnboard()
    loadLogined()
    observeUserChange()
  }

  @Published var showOnboard = false
  func loadShowOnboard() {
    guard let current = Bundle.main.versionNumber else { return }
    if let boarded = defaults.boardedVersion {
      showOnboard = current.compare(boarded, options: .numeric) == .orderedDescending
    } else {
      showOnboard = true
    }
  }
  func didOnboard() {
    defaults.boardedVersion = Bundle.main.versionNumber
  }

  @Published var logined = false
  func loadLogined() {
    resetEnvs(switcher.user)
    logined = switcher.user != nil
  }
  func observeUserChange() {
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
  func resetEnvs(_ user: User?) {
    print("reset")
  }

}
