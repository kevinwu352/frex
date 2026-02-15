//
//  LoginViewController.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import UIKit
//import CoreBase
//import Factory
import SnapKit

class LoginViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green

    view.addSubview(enterBtn)
    enterBtn.snp.remakeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  lazy var enterBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle("Login", for: .normal)
    ret.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
    return ret
  }()
  @objc func enterAction() {
//    Container.shared.defaults().boardedVersion = Bundle.main.versionNumber
  }

}
