//
//  Endpoint.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation

public protocol Endpoint {
  var path: String { get }
  var method: ReqMethod { get }
  var parameters: [String: Encodable]? { get }
  var encoding: ReqEncoding { get }
  var headers: [String: String]? { get }
}

extension Endpoint {
  func req(_ host: String, _ heads: [String: String]) throws(ReqError) -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    guard let url = components.url else {
      throw .badURL
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = heads.merging(headers ?? [:]) { $1 }
    let ret = try encoding.value.encode(request, parameters)
    return ret
  }
}
