//
//  TestViewController.swift
//  frex
//
//  Created by Kevin Wu on 2/8/26.
//

import UIKit
import Combine
import CoreBase

class TestViewController: UIViewController {
  lazy var bag = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
}
