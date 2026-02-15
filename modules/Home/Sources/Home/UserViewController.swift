//
//  UserViewController.swift
//  Home
//
//  Created by Kevin Wu on 2/15/26.
//

import UIKit
import Factory

class UserViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(logoutBtn)
    logoutBtn.snp.remakeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  lazy var logoutBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle("Logout", for: .normal)
    ret.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
    return ret
  }()
  @objc func logoutAction() {
    switcher.logout()
  }

  let switcher = Container.shared.switcher()
}
