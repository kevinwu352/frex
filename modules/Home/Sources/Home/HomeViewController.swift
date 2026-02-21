//
//  HomeViewController.swift
//  Line
//
//  Created by Kevin Wu on 2/14/26.
//

import CoreBase
import UIKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    navigationController?.pushViewController(RefreshViewController(), animated: true)
  }

}
