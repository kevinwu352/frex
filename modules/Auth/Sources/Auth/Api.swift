//
//  Api.swift
//  Auth
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation
import CoreBase

struct Api: Endpoint {
  var path: String
  var method: ReqMethod
  var parameters: [String: Encodable]?
  var encoding: ReqEncoding = .url
  var headers: [String: String]?
}

extension Api {
  static func login() -> Self {
    .init(path: "/c/a6a7-7025-46a6-bdb2", method: .get)
  }
}

// https://dummyjson.com/c/a6a7-7025-46a6-bdb2
// [
//   {
//     "id": 1,
//     "name": "Ervin Howell",
//     "username": "ervinh",
//     "email": "ervinh110@melissa.tv",
//     "phone": "010-692-6593",
//     "website": "ervinh.net",
//     "token": "token_111-ervinh"
//   }, {
//     "id": 2,
//     "name": "Leanne Graham",
//     "username": "leanneg",
//     "email": "leanneg110@april.biz",
//     "phone": "021-736-8031",
//     "website": "leanneg.org",
//     "token": "token_222-leanneg"
//   }
// ]
