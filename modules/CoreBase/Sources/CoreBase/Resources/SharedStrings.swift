//
//  SharedStrings.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import Foundation

extension String {
  // 用第一种方式
  public static let kWelcomeMsg = String(localized: "welcom_msg", bundle: .module)
  // 最初试的时候，第一种方式不行，但第二次又行了，如果没意外的话，用第一种方式
  public static var kFirstMsg: String { String(localized: "first_msg", bundle: .module) }
}
