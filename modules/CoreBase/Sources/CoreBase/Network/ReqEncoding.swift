//
//  ReqEncoding.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation

public enum ReqEncoding {
  case url
  case json
  var value: ParaEncoding {
    switch self {
    case .url: URLEncoding.default
    case .json: JSONEncoding.default
    }
  }
}

protocol ParaEncoding {
  func encode(request: URLRequest, parameters: [String: Encodable]?) throws(ReqError) -> URLRequest
}

struct URLEncoding: ParaEncoding {

  static let `default` = URLEncoding()

  func encode(request: URLRequest, parameters: [String: Encodable]?) throws(ReqError) -> URLRequest {
    guard let parameters else { return request }

    var request = request

    if request.httpMethod == "GET" {
      guard let url = request.url else {
        throw .badURL
      }
      if var components = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
        let query = (components.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
        components.percentEncodedQuery = query
        request.url = components.url
      }
    } else {
      if request.allHTTPHeaderFields?["Content-Type"] == nil {
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
      }
      request.httpBody = Data(query(parameters).utf8)
    }

    return request
  }

  func query(_ parameters: [String: Any]) -> String {
    parameters
      .mapValues { "\($0)" }
      .mapValues { $0.addingPercentEncoding(withAllowedCharacters: .queryAllowed) ?? $0 }
      .map { "\($0.key)=\($0.value)" }
      .joined(separator: "&")
  }
}
extension CharacterSet {
  /// Creates a CharacterSet from RFC 3986 allowed characters.
  ///
  /// RFC 3986 states that the following characters are "reserved" characters.
  ///
  /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
  /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
  ///
  /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
  /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
  /// should be percent-escaped in the query string.
  fileprivate static let queryAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="
    let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
  }()
}

struct JSONEncoding: ParaEncoding {

  static let `default` = JSONEncoding()

  func encode(request: URLRequest, parameters: [String: Encodable]?) throws(ReqError) -> URLRequest {
    guard let parameters else { return request }

    guard JSONSerialization.isValidJSONObject(parameters) else {
      throw .badJSON
    }

    var request = request
    do {
      let data = try JSONSerialization.data(withJSONObject: parameters)
      if request.allHTTPHeaderFields?["Content-Type"] == nil {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
      request.httpBody = data
    } catch {
      throw .badJSON
    }

    return request
  }
}
