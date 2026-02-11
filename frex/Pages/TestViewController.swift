//
//  TestViewController.swift
//  frex
//
//  Created by Kevin Wu on 2/11/26.
//

import UIKit
import CoreBase

extension Storage {
  public var name: String? {
    get { string(forKey: "nnn") }
    set { setString(newValue, forKey: "nnn") }
  }
  public var age: Int? {
    get { int(forKey: "aaa") }
    set { setInt(newValue, forKey: "aaa") }
  }
}

class TestViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}
