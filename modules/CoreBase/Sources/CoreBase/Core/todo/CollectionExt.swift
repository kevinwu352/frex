//
//  CollectionExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/1/26.
//

import Foundation

extension Collection {

  public var notEmpty: Bool { !isEmpty }

  public func at(_ i: Index) -> Element? {
    indices.contains(i) ? self[i] : nil
  }

}

// TODO: add more if needed
