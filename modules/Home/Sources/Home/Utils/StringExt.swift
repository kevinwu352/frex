//
//  StringExt.swift
//  Home
//
//  Created by Kevin Wu on 2/14/26.
//

import Foundation

// 旧项目用这个
//   NSLocalizedString
// 这个功效非常强，就算写在注释里面，也能加到 xcstrings 里面去，不要用这个
// 这东西还要指定 bundle: .module，比较麻烦
// 就算删了这条，xcstrings 里面也不会删除
// 如果修改它的 key，xcstrings 里会新加一条，也不是删除旧的增加新的
// 反正就是很麻烦，不要用
//
// 新项目一定要用这个，这东西更新的比较好，如果我修改了某条，它会会删旧的加新的
//   String(localized: "")
extension String {
  init(localized keyAndValue: String.LocalizationValue) {
    self.init(localized: keyAndValue, bundle: .module)
  }
}
