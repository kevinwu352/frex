//
//  SettingsViewController.swift
//  Home
//
//  Created by Kevin Wu on 2/14/26.
//

import CoreBase
import Factory
import UIKit

class SettingsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray

    stackView2.addArrangedSubviews([button4])
    view.addSubviews([stackView2, label1, label2, label3, label4])
    stackView2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
    }
    label1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(stackView2.snp.bottom).offset(10)
    }
    label2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(label1.snp.bottom).offset(10)
    }
    label3.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(label2.snp.bottom).offset(10)
    }
    label4.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(label3.snp.bottom).offset(10)
    }

    stackView1.addArrangedSubviews([button1, button2, button3])
    view.addSubviews([stackView1, imageView1, imageView2, imageView3, imageView4])
    stackView1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
    imageView1.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(stackView1.snp.top).offset(-10)
    }
    imageView2.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(imageView1.snp.top).offset(-10)
    }
    imageView3.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(imageView2.snp.top).offset(-10)
    }
    imageView4.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(imageView3.snp.top).offset(-10)
      make.size.equalTo(CGSize(width: 80, height: 80))
    }
  }

  lazy var label1: UILabel = {
    let ret = UILabel()
    ret.text = String(localized: "text_in_mod")
    return ret
  }()

  lazy var label2: UILabel = {
    let ret = UILabel()
    ret.text = .kWelcomeMsg
    return ret
  }()

  lazy var label3: UILabel = {
    let ret = UILabel()
    ret.text = .kFirstMsg
    return ret
  }()

  lazy var label4: UILabel = {
    let ret = UILabel()
    // 要将字符串同步到 xcstrings 文件中，直接在这里写就行了
    // 如果有参数，写 "xxx_\("")"，这会自动生成 xxx_%@
    //   然后在项目其它地方，就可以传真正的值，它们会使用同一个 key
    // 如果是复数，写 "yyy_\(0)"，这会自动生成 yyy_%lld，然后在 xcstrings 文件中进行复数变换
    //   然后在项目其它地方，就可以传真正的值，它们会使用同一个 key
    ret.text = String(localized: "this_is_a_\("")")
    ret.text = String(localized: "you_got_n_apple_\(0)")
    // 两个变量的顺序，写的时候一定要写在后面，方便 key 在 xcstrings 文件中排序
    ret.text = String(localized: "you_have_a_and_b_\("11")_\("22")")
    return ret
  }()
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    label4.text = String(localized: "you_got_n_apple_\(2)")
    label4.text = String(localized: "this_is_a_\("asdf")")
    label4.text = String(localized: "you_have_a_and_b_\("111")_\("222")")
  }

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
    // 对于多语言
    // 要在主工程里面建一个 Localizable.xcstrings
    // 并且要添加一个条目，还要将这条打印在控制台
    // 并且还要给这个条目增加翻译
    // Settings 里面才会出现选择语言的选项
    //
    // 我感觉关键点是：要在 main bundle 里面生成几个 lproj 目录，才会显示切换语言的选项
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)

    // 在系统设置里修改语言后，马上能像这样拿到当前语言
    // if let lan = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
    //   label1.text = lan.first
    // }
  }

  lazy var imageView1: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = UIColor(resource: .testClr)
    ret.image = UIImage(resource: .testImg)
    // ret.image = ImageResource.testImg.cur
    return ret
  }()

  lazy var imageView2: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = UIColor(resource: .kViewBg11)
    ret.image = UIImage(resource: .kFlatCloud11)
    // ret.image = ImageResource.kFlatCloud11.cur
    return ret
  }()

  lazy var imageView3: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = .kViewBg
    ret.image = .kFlatCloud
    return ret
  }()

  lazy var imageView4: UIImageView = {
    let ret = UIImageView()
    ret.backgroundColor = .kViewBg
    ret.image = UIImage(resource: .mount)
    // ret.image = ImageResource.mount.cur
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
      // view.overrideUserInterfaceStyle = .light
      // overrideUserInterfaceStyle = .light
    } else if sender.tag == 2 {
      view.window?.overrideUserInterfaceStyle = .dark
      Container.shared.defaults().theme = .night
      // view.overrideUserInterfaceStyle = .dark
      // overrideUserInterfaceStyle = .dark
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
