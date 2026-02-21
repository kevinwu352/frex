//
//  RefreshViewController.swift
//  Home
//
//  Created by Kevin Wu on 2/21/26.
//

import CoreBase
import Factory
import UIKit

class RefreshViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(scrollView)
    view.addSubview(changeBtn)

    scrollView.headHandler = { [weak self] in
      print("head, begin")
      DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
        print("head, end")
        self?.scrollView.headEndRefreshing()
        self?.scrollView.footReset(show: true, more: true)
      }
    }
    scrollView.headReset(show: true)

    scrollView.footHandler = { [weak self] in
      print("foot, begin")
      DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
        print("foot, end")
        self?.scrollView.footReset(show: false, more: false)
      }
    }
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 50)
    changeBtn.sizeToFit()
    changeBtn.frame = CGRect(x: 0, y: 0, width: changeBtn.bounds.width + 100, height: changeBtn.bounds.height)
    changeBtn.center = view.center
  }

  let defaults = Container.shared.defaults()

  lazy var scrollView: UIScrollView = {
    let ret = UIScrollView()
    ret.backgroundColor = .lightGray
    return ret
  }()

  lazy var changeBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle(defaults.theme?.rawValue ?? "nil", for: .normal)
    ret.addTarget(self, action: #selector(changeAction), for: .touchUpInside)
    return ret
  }()
  @objc func changeAction() {
    let theme = defaults.theme
    if theme == .day {
      print("light => dark")
      defaults.theme = .night
      view.window?.overrideUserInterfaceStyle = .dark
    } else if theme == .night {
      print("dark => light")
      defaults.theme = .day
      view.window?.overrideUserInterfaceStyle = .light
    } else {
      print("nil => light")
      defaults.theme = .day
      view.window?.overrideUserInterfaceStyle = .light
    }
    changeBtn.setTitle(defaults.theme?.rawValue ?? "nil", for: .normal)
  }

}
