//
//  HomeViewController.swift
//  frex
//
//  Created by Kevin Wu on 2/8/26.
//

import UIKit
import Combine
import SnapKit
import CoreBase

class HomeViewController: UIViewController {
  lazy var bag = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cyan
    navigationItem.title = "Home"

//    let bt = UIButton(type: .custom)
//    bt.setImage(.alien, for: .normal)
//    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bt)

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DDD", style: .plain, target: self, action: #selector(handle))
//    navigationItem.rightBarButtonItem = UIBarButtonItem(image: .alien, style: .plain, target: self, action: #selector(handle))
//    if #available(iOS 26.0, *) {
//      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DDD", style: .prominent, target: self, action: #selector(handle))
//      navigationItem.rightBarButtonItem = UIBarButtonItem(image: .alien, style: .plain, target: self, action: #selector(handle))
//    } else {
//      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DDD", style: .plain, target: self, action: #selector(handle))
//    }

    view.addSubview(scrollView)
    scrollView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }
    scrollView.addSubview(imageView)
    imageView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(1000)
    }

  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    navigationController?.pushViewController(TestViewController(), animated: true)
  }

  @objc func handle() {
    print("handle")
  }

  lazy var scrollView: UIScrollView = {
    let ret = UIScrollView()
    ret.isUserInteractionEnabled = false
    return ret
  }()

  lazy var imageView: UIImageView = {
    let ret = UIImageView()
    ret.image = .girl
    ret.contentMode = .scaleToFill
    return ret
  }()
}
