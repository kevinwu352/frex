//
//  SettingsViewController.swift
//  Home
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit
import CoreBase

class SettingsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray

    view.addSubview(imageView1)
    imageView1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
    }

    view.addSubview(imageView2)
    imageView2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(imageView1.snp.bottom).offset(10)
    }

    view.addSubview(imageView3)
    imageView3.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(imageView2.snp.bottom).offset(10)
    }

    stackView.addArrangedSubviews([button1, button2])
    view.addSubview(stackView)
    stackView.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
  }

  lazy var imageView1: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = UIColor(resource: .testClr)
    ret.image = UIImage(resource: .testImg)
    return ret
  }()

  lazy var imageView2: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = UIColor(resource: .kViewBg11)
    ret.image = UIImage(resource: .kFiatCloud11)
    return ret
  }()

  lazy var imageView3: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = .kViewBg
    ret.image = .kFiatCloud
    return ret
  }()

  lazy var stackView: UIStackView = {
    let ret = UIStackView()
    ret.axis = .horizontal
    ret.alignment = .fill
    ret.distribution = .equalSpacing
    ret.spacing = 10
    return ret
  }()

  lazy var button1: UIButton = {
    let ret = UIButton(type: .system)
    ret.tag = 1
    ret.setTitle("light", for: .normal)
    ret.addTarget(self, action: #selector(themeAction), for: .touchUpInside)
    return ret
  }()

  lazy var button2: UIButton = {
    let ret = UIButton(type: .system)
    ret.tag = 2
    ret.setTitle("dark", for: .normal)
    ret.addTarget(self, action: #selector(themeAction), for: .touchUpInside)
    return ret
  }()

  @objc func themeAction(_ sender: UIButton) {
    let value = self.view.window?.overrideUserInterfaceStyle
    print(value?.name ?? "")
    if sender.tag == 1 {
      view.window?.overrideUserInterfaceStyle = .light
    } else {
      view.window?.overrideUserInterfaceStyle = .dark
    }
  }

}

extension UIUserInterfaceStyle {
  var name: String {
    switch self {
    case .unspecified: "unspecified"
    case .light: "light"
    case .dark: "dark"
    @unknown default:
      "unknown default"
    }
  }
}
