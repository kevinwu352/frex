//
//  HomeViewController.swift
//  Line
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit
import CoreBase

public class HomeViewController: UIViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white // .white // UIColor(resource: .kViewBg)
    navigationItem.title = "Home"

    view.addSubview(imageView)
    view.addSubview(label)
  }
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    imageView.frame = view.bounds
    label.sizeToFit()
    label.center = view.center
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    navigationController?.pushViewController(TestViewController(), animated: true)
  }

  lazy var imageView: UIImageView = {
    let ret = UIImageView()
//    ret.image = UIImage(resource: .mount)

    ret.backgroundColor = .kTextPrimary
    ret.image = .kFiatCloud
//    ret.backgroundColor = UIColor(resource: .kTextPrimary11)
//    ret.image = UIImage(resource: .kFiatCloud11)

    return ret
  }()

  lazy var label: UILabel = {
    let ret = UILabel()
    ret.font = .body
    ret.text = "asdf"
    return ret
  }()

}
