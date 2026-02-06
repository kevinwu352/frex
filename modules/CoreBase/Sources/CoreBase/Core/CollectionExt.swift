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

// MARK: - 获取子内容

// [ ] min / min(by: xxx)
// [ ] max / max(by: xxx)

// [ ] first / last
// [ ] randomElement

// [ ] prefix                     [0...∞]
// [ ] prefix(upTo: xxx)          前 n 个，效果同上
// [ ] prefix(through: xxx)       前 n+1 个
// [ ] prefix(while: xxx)         第一次 false 之前所有的
// [ ] suffix                     [0...∞]
// [ ] suffix(from: xxx)          去掉前 n 个，剩下的

// [ ] first(where: xxx)
// [ ] firstIndex(of: xxx)
// [ ] firstIndex(where: xxx)
// [ ] last(where: xxx)
// [ ] lastIndex(of: xxx)
// [ ] lastIndex(where: xxx)

// MARK: - 检查子内容

// [ ] contains(xxx)
// [ ] allSatisfy(xxx)            []:true
//
// [S] hasPrefix(xxx)
// [S] hasSuffix(xxx)

// MARK: - 增删内容

// [ ] a = a + [x]
// [ ] a += [x]
// [ ] append(x)
// [ ] append(contentsOf: [x])

// [ ] insert(x, at: a.startIndex)                    [0...count]
// [ ] insert(contentsOf: [x], at: a.startIndex)      [0...count]

// [ ] remove(at: n)                                  [0..<count] 会返回被移除的值
// [ ] removeFirst() / removeLast()                   crash on empty collection 会返回被移除的值
// [ ] removeFirst(n) / removeLast(n)                 [0...count]
// [ ] dropFirst(n)   / dropLast(n)                   不改变原集合
// [ ] removeAll      / removeAll(where: xxx)         筛掉所有为 true 的，会改变原集合
// [ ]                / drop(while: xxx)              筛掉为 true 的，直到第一个 false 出现，停止，不会改变原集合
// [ ] removeSubrange(1...3)                          [0..<0, count..<count]

// [ ] replaceSubrange                                [0..<0, count..<count]
// [S] replacingOccurrences(of:, with:)

// MARK: - 高阶方法

// [ ] forEach
// [ ] map / compactMap
// [ ] filter / drop(while: xxx) / removeAll(where: xxx)
// [ ] reduce
// [ ] flatMap

// MARK: - 排序

// [A] sort / sorted
// [A] reverse / reversed
// [A] shuffle / shuffled
// [A] swapAt                   [0..<count]

// MARK: - 字典

// [D] updateValue(_,forKey:)    // 返回旧值，能判断新加或更新
// [D] removeValue(forKey:)      // 返回旧值
// [D] removeAll(keepingCapacity:)

// [D] merge(_:uniquingKeysWith:)     // 改变原集合
// [D] merging(_:uniquingKeysWith:)   // 返回新集合

// [D] forEach(_:)
// [D] map(_:) / compactMap(_:)                // 返回数组
// [D] mapValues(_:) / compactMapValues(_:)    // 返回字典
// [D] filter(_:)
// [D] reduce(_:_:)
// [D] flatMap(_:)

// [D] first(where:)     // 返回元组 (key,value)
// [D] min(by:)
// [D] max(by:)
