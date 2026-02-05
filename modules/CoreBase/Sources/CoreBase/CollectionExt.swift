//
//  CollectionExt.swift
//  frex
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation

public extension Collection {

  var notEmpty: Bool { !isEmpty }

  func at(_ i: Index) -> Element? {
    indices.contains(i) ? self[i] : nil
  }

}

// TODO: add more if needed
