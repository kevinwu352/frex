//
//  SettingsViewController.swift
//  Home
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit
import CoreBase
import Factory

class SettingsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray


    stackView2.addArrangedSubviews([button4])
    view.addSubview(stackView2)
    stackView2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
    }

    view.addSubview(label1)
    label1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(stackView2.snp.bottom).offset(10)
    }

    view.addSubview(label2)
    label2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(label1.snp.bottom).offset(10)
    }


    stackView1.addArrangedSubviews([button1, button2, button3])
    view.addSubview(stackView1)
    stackView1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }

    view.addSubview(imageView1)
    imageView1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(stackView1.snp.top).offset(-10)
    }
    view.addSubview(imageView2)
    imageView2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(imageView1.snp.top).offset(-10)
    }
    view.addSubview(imageView3)
    imageView3.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(imageView2.snp.top).offset(-10)
    }
  }

  lazy var label1: UILabel = {
    let ret = UILabel()
    ret.text = NSLocalizedString("test_lan", bundle: .module, comment: "")
    return ret
  }()

  lazy var label2: UILabel = {
    let ret = UILabel()
    ret.text = "bbb"
    return ret
  }()

  lazy var stackView2: UIStackView = {
    let ret = UIStackView()
    ret.axis = .horizontal
    ret.alignment = .fill
    ret.distribution = .equalSpacing
    ret.spacing = 10
    return ret
  }()

  lazy var button4: UIButton = {
    let ret = UIButton(type: .system)
    ret.tag = 1
    ret.setTitle("go", for: .normal)
    ret.addTarget(self, action: #selector(languageAction), for: .touchUpInside)
    return ret
  }()

  @objc func languageAction(_ sender: UIButton) {
    guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
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

  lazy var stackView1: UIStackView = {
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

  lazy var button3: UIButton = {
    let ret = UIButton(type: .system)
    ret.tag = 3
    ret.setTitle("--", for: .normal)
    ret.addTarget(self, action: #selector(themeAction), for: .touchUpInside)
    return ret
  }()

  @objc func themeAction(_ sender: UIButton) {
    let value = self.view.window?.overrideUserInterfaceStyle
    print(value?.name ?? "")

    // overrideUserInterfaceStyle 这参数能给 UIWindow/UIView/UIViewController，修改对应的
    // 推荐修改 UIWindow 的
    if sender.tag == 1 {
      Container.shared.defaults().theme = .day
      view.window?.overrideUserInterfaceStyle = .light
//      view.overrideUserInterfaceStyle = .light
//      overrideUserInterfaceStyle = .light
    } else if sender.tag == 2 {
      view.window?.overrideUserInterfaceStyle = .dark
      Container.shared.defaults().theme = .night
//      view.overrideUserInterfaceStyle = .dark
//      overrideUserInterfaceStyle = .dark
    } else {
      view.window?.overrideUserInterfaceStyle = .unspecified
      Container.shared.defaults().theme = nil
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
