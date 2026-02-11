//
//  UIViewExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/8/26.
//

import UIKit

// autocapitalizationType = .none
// autocorrectionType = .no
// spellCheckingType = .no

// shadowColor
// shadowRadius   3.0           半径，值越大阴影延伸的越远越淡
// shadowOpacity  0.0           不透明度，最大值 1
// shadowOffset   (0.0, -3.0)   偏移量，负值往左上偏移

// cancelsTouchesInView = true  手势识别成功后是否取消视图的触摸事件，通过发送 touch cancelled
// delaysTouchesBegan = false   手势识别成功后视图收不到触摸事件，失败后才会发 touch began 给视图
// delaysTouchesEnded = true    手势识别成功后视图收到 touch cancelled，失败后才会发 touch ended 给视图

// ValueControl
//
// private(set) var current = 0
// var didChange: ((Int) -> Void)?
//
// func reset(_ value: Int, animated: Bool, notify: Bool) {
//   let oldValue = current
//   current = value
//   reload(oldValue, animated: animated)
//   if notify {
//     didChange?(value)
//   }
// }
// func reload(_ old: Int?, animated: Bool) {
//   stackView.arrangedSubviews
//     .compactMap { $0 as? UIButton }
//     .forEach { $0.setTitleColor($0.tag == current ? .red : .blue, for: .normal) }
// }
//
// // init
// reload(nil, animated: false)
//
// // fire
// reset(sender.tag, animated: true, notify: true)

extension UIView {

  public static var reuseId: String {
    String(describing: self)
  }
  public var isShown: Bool {
    get { !isHidden }
    set { isHidden = !newValue }
  }
  public var imageRep: UIImage {
    UIGraphicsImageRenderer(bounds: bounds).image {
      layer.render(in: $0.cgContext)
    }
  }
  public var firstResponder: UIResponder? {
    if isFirstResponder {
      return self
    }
    for view in subviews {
      if let responder = view.firstResponder {
        return responder
      }
    }
    return nil
  }

  // MARK: -

  public func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
  public func removeAllSubviews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
  public func bringToFront() {
    superview?.bringSubviewToFront(self)
  }
  public func sendToBack() {
    superview?.sendSubviewToBack(self)
  }

  // MARK: -

  public func kangLa(_ priority: UILayoutPriority, _ axis: NSLayoutConstraint.Axis? = nil) { // LABEL
    if let axis {
      setContentHuggingPriority(priority, for: axis)
    } else {
      setContentHuggingPriority(priority, for: .horizontal)
      setContentHuggingPriority(priority, for: .vertical)
    }
  }
  public func kangYa(_ priority: UILayoutPriority, _ axis: NSLayoutConstraint.Axis? = nil) { // LABEL
    if let axis {
      setContentCompressionResistancePriority(priority, for: axis)
    } else {
      setContentCompressionResistancePriority(priority, for: .horizontal)
      setContentCompressionResistancePriority(priority, for: .vertical)
    }
  }
  public func degradeLaya(_ value: Int, _ axis: NSLayoutConstraint.Axis? = nil) { // LABEL
    if let axis {
      setContentHuggingPriority(.defaultLow - Float(value), for: axis)
      setContentCompressionResistancePriority(.defaultHigh - Float(value), for: axis)
    } else {
      setContentHuggingPriority(.defaultLow - Float(value), for: .horizontal)
      setContentHuggingPriority(.defaultLow - Float(value), for: .vertical)
      setContentCompressionResistancePriority(.defaultHigh - Float(value), for: .horizontal)
      setContentCompressionResistancePriority(.defaultHigh - Float(value), for: .vertical)
    }
  }

  // MARK: -

  // 深度优先
  public func descendant<T: UIView>(_ cls: T.Type) -> T? {
    if self is T {
      return self as? T
    }
    for view in subviews {
      if let ret = view.descendant(cls) {
        return ret
      }
    }
    return nil
  }
  public func ancestor<T: UIView>(_ cls: T.Type) -> T? {
    if self is T {
      return self as? T
    } else {
      return superview?.ancestor(cls)
    }
  }
  public var ownerVc: UIViewController? {
    var responder: UIResponder? = self
    while !(responder is UIViewController) {
      responder = responder?.next
      if responder == nil { break }
    }
    return responder as? UIViewController
  }

  // MARK: -

  // To use in code
  //   set View - Custom Class
  //   in code: XXXView.loadFromNib()
  public static func loadFromNib() -> Self {
    UINib(nibName: String(describing: self), bundle: Bundle(for: self))
      .instantiate(withOwner: nil, options: nil).first as? Self ?? .init()
  }
  // To use in another xib
  //   set File's Owner - Custom Class
  //   in another xib, add a UIView, set its Custom Class
  //   in code: awakeFromNib() { ... }
  public func loadContentFromNib() {
    UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
      .instantiate(withOwner: self, options: nil)
      .compactMap { $0 as? UIView }
      .forEach {
        $0.translatesAutoresizingMaskIntoConstraints = false
        addSubview($0)
        topAnchor.constraint(equalTo: $0.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: $0.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: $0.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: $0.trailingAnchor).isActive = true
      }
  }

}

// MARK: -

extension UIStackView {
  public func addArrangedSubviews(_ views: [UIView]) {
    views.forEach { addArrangedSubview($0) }
  }
  public func removeAllArrangedSubviews() {
    arrangedSubviews.forEach { $0.removeFromSuperview() }
  }
}

// MARK: -

extension UIViewController {
  public func addSubvc(_ child: UIViewController, inView: UIView?) {
    addChild(child)
    (inView ?? view).addSubview(child.view)
    child.didMove(toParent: self)
  }
  public func removeSubvc(_ child: UIViewController) {
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
  }
}
