//
//  UIScrollView_Container.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/14/26.
//

import SnapKit
import UIKit

extension UIScrollView {

  class ContentView: UIView {}

  public var contentView: UIView? {
    subviews.first { $0 is ContentView }
  }

  public func addContentView(_ axis: NSLayoutConstraint.Axis, edges: UIEdgeInsets) {
    if contentView == nil {
      let content = ContentView()
      addSubview(content)
    }
    if axis == .vertical {
      showsHorizontalScrollIndicator = false
    } else {
      showsVerticalScrollIndicator = false
    }
    contentView?.snp.remakeConstraints { make in
      make.edges.equalToSuperview().inset(edges)
      if axis == .vertical {
        make.width.equalToSuperview().offset(-(edges.left + edges.right))
      } else {
        make.height.equalToSuperview().offset(-(edges.top + edges.bottom))
      }
    }
  }

  public var stackView: UIStackView? {
    subviews.first(where: { $0 is UIStackView }) as? UIStackView
  }

  public func addStackView(_ axis: NSLayoutConstraint.Axis, edges: UIEdgeInsets) {
    if stackView == nil {
      let stack = UIStackView()
      stack.axis = axis
      stack.alignment = .fill
      stack.distribution = .equalSpacing
      stack.spacing = 0
      addSubview(stack)
    }
    if axis == .vertical {
      showsHorizontalScrollIndicator = false
    } else {
      showsVerticalScrollIndicator = false
    }
    stackView?.snp.remakeConstraints { make in
      make.edges.equalToSuperview().inset(edges)
      if axis == .vertical {
        make.width.equalToSuperview().offset(-(edges.left + edges.right))
      } else {
        make.height.equalToSuperview().offset(-(edges.top + edges.bottom))
      }
    }
  }

}

// func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//   guard !decelerate else { return }
// }
// func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { }
// func scrollViewDidScrollToTop(_ scrollView: UIScrollView) { }
extension UIScrollView {
  public var pageIndexX: Int {
    guard frame.width > 0 else { return 0 }
    let value = contentOffset.x / frame.width
    let index = Int(ceil(value))
    return index
  }
  public var pageIndexY: Int {
    guard frame.height > 0 else { return 0 }
    let value = contentOffset.y / frame.height
    let index = Int(ceil(value))
    return index
  }
}
