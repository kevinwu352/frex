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

    view.addSubview(login1Btn)
    login1Btn.snp.remakeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalTo(view.snp.centerX).offset(-10)
    }

    view.addSubview(login2Btn)
    login2Btn.snp.remakeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(view.snp.centerX).offset(10)
    }
  }

  var vm = LoginViewModel(repo: LoginRepository())

  lazy var login1Btn: UIButton = {
    let ret = UIButton(type: .system)
    ret.tag = 1
    ret.setTitle("Login-111", for: .normal)
    ret.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    return ret
  }()
  lazy var login2Btn: UIButton = {
    let ret = UIButton(type: .system)
    ret.tag = 2
    ret.setTitle("Login-222", for: .normal)
    ret.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    return ret
  }()
  @objc func loginAction(_ sender: UIButton) {
    vm.login(sender.tag)
  }

}
