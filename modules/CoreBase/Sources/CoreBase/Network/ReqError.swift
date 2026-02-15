//
//  ReqError.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation

public enum ReqError: Error {
  case badURL
  case badJSON

  case serverError
  case codeError
  case dataError
  case decodeError
}
