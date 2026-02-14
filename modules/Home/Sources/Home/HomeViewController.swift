//
//  HomeViewController.swift
//  Line
//
//  Created by Kevin Wu on 2/14/26.
//

import UIKit

public class HomeViewController: UIViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    navigationItem.title = "Home"

    view.addSubview(imageView)
  }
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    imageView.frame = view.bounds
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    navigationController?.pushViewController(TestViewController(), animated: true)
  }

  lazy var imageView: UIImageView = {
    let ret = UIImageView()
    ret.image = UIImage(resource: .mount)
    return ret
  }()

}
