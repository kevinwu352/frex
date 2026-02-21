//
//  UserViewController.swift
//  Home
//
//  Created by Kevin Wu on 2/15/26.
//

import CoreBase
import Factory
import UIKit

class UserViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(httpBtn)
    httpBtn.snp.remakeConstraints { make in
      make.center.equalToSuperview()
    }

    view.addSubview(userBtn)
    userBtn.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(httpBtn.snp.bottom).offset(20)
    }

    view.addSubview(logoutBtn)
    logoutBtn.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(userBtn.snp.bottom).offset(20)
    }
  }

  lazy var httpBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle("HTTP", for: .normal)
    ret.addTarget(self, action: #selector(httpAction), for: .touchUpInside)
    return ret
  }()
  @objc func httpAction() {
    Task {
      print(self.network)
      let list = try await self.network.request(UserApi.blah(), type: Users.self)
      print(list)
    }
  }

  lazy var userBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle("User", for: .normal)
    ret.addTarget(self, action: #selector(userAction), for: .touchUpInside)
    return ret
  }()
  @objc func userAction() {
    print(usermg)
  }

  let usermg = Container.shared.usermg()
  let network = Container.shared.network()

  lazy var logoutBtn: UIButton = {
    let ret = UIButton(type: .system)
    ret.setTitle("Logout", for: .normal)
    ret.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
    return ret
  }()
  @objc func logoutAction() {
    Container.shared.switcher().logout()
  }
}

struct UserApi: Endpoint {
  var path: String
  var method: ReqMethod
  var parameters: [String: Encodable]?
  var encoding: ReqEncoding = .url
  var headers: [String: String]?
}
extension UserApi {
  static func blah() -> Self {
    .init(path: "/c/a6a7-7025-46a6-bdb2", method: .get)
  }
}
