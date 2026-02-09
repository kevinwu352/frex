//
//  RootViewController.swift
//  frex
//
//  Created by Kevin Wu on 2/4/26.
//

import UIKit
import Combine
import CoreBase

class RootViewController: UIViewController {
  lazy var bag = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemTeal
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    navigationController?.pushViewController(TestViewController(), animated: true)
  }

}
