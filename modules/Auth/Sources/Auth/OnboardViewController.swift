//
//  OnboardViewController.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import CoreBase
import Factory
import SnapKit
import UIKit

class OnboardViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow

    view.addSubview(enterBtn)
    enterBtn.snp.remakeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  lazy var enterBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle("Enter", for: .normal)
    ret.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
    return ret
  }()
  @objc func enterAction() {
    Container.shared.defaults().boardedVersion = Bundle.main.versionNumber
  }

}
