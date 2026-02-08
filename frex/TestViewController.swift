//
//  TestViewController.swift
//  frex
//
//  Created by Kevin Wu on 2/8/26.
//

import UIKit
import Combine
import CoreBase

class Btn: UIButton {
  deinit {
    print("btn deinit")
  }
}

class TestViewController: UIViewController {

  public lazy var cancellables = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    let btn = Btn(type: .system)
    btn.setTitle("doit", for: .normal)
    view.addSubview(btn)
    btn.sizeToFit()
    btn.center = view.center

    btn.tap.sink {
      print("clicked")
    }
    .store(in: &cancellables)

  }

  deinit {
    print("test vc deinit")
  }

}
