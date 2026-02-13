//
//  UIButton_Style.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/13/26.
//

import UIKit
import CoreImage.CIFilterBuiltins

public class StyButton: UIButton {

  public enum Status {
    case normal
    case highlighted
    case disabled
    public init(_ state: UIControl.State) {
      if state == .highlighted || state == .selected {
        self = .highlighted
      } else if state == .disabled {
        self = .disabled
      } else {
        if state.rawValue == UIControl.State.highlighted.rawValue | UIControl.State.selected.rawValue { // 5
          self = .highlighted
        } else {
          self = .normal
        }
      }
    }
    public var norm: Bool { self == .normal }
    public var high: Bool { self == .highlighted }
    public var dis: Bool { self == .disabled }
  }

  // 系统高亮
  //   (template, color)，务必给个颜色，否则会用系统某个颜色值。（如果传 original，颜色不起作用）
  // 自动高亮
  //   (template, color).high()，要给颜色，用颜色算出一个高亮颜色。（不准传 original）
  //   (original, nil  ).high()，不给颜色，用图片算出一个高亮图片。（不准传 template）
  // imageReservation
  public struct Image {
    public var image: (Status) -> (UIImage?, UIColor?)
    public var spacing: ((Status) -> Double?)?
    public var alignment: ((Status) -> NSDirectionalRectEdge?)?
    public var autohigh = false
    public init(image: @escaping (Status) -> (UIImage?, UIColor?),
                spacing: ((Status) -> Double?)? = nil,
                alignment: ((Status) -> NSDirectionalRectEdge?)? = nil,
                autohigh: Bool = false
    ) {
      self.image = image
      self.spacing = spacing
      self.alignment = alignment
      self.autohigh = autohigh
    }
    func apply(_ conf: inout Configuration?, status: Status) {
      let img = image(status)
      if autohigh {
        if img.1 != nil {
          conf?.image = img.0
          conf?.baseForegroundColor = img.1?.turn(status.high)
        } else {
          conf?.image = img.0?.turn(status.high, nil)
        }
      } else {
        conf?.image = img.0
        conf?.baseForegroundColor = img.1
      }
      if let spacing = spacing?(status) {
        conf?.imagePadding = spacing
      }
      if let alignment = alignment?(status) {
        conf?.imagePlacement = alignment
      }
    }
  }
  public var image: Image? {
    didSet { setNeedsStyle() }
  }

  // titleLineBreakMode
  // subtitleLineBreakMode
  public struct Title {
    public var str: (Status) -> String?
    public var font: (Status) -> UIFont?
    public var color: (Status) -> UIColor?
    public var spacing: ((Status) -> Double?)?
    public var alignment: ((Status) -> Configuration.TitleAlignment?)?
    public var autohigh = false
    public init(str: @escaping (Status) -> String?,
                font: @escaping (Status) -> UIFont?,
                color: @escaping (Status) -> UIColor?,
                spacing: ((Status) -> Double?)? = nil,
                alignment: ((Status) -> Configuration.TitleAlignment?)? = nil,
                autohigh: Bool = false
    ) {
      self.str = str
      self.font = font
      self.color = color
      self.spacing = spacing
      self.alignment = alignment
      self.autohigh = autohigh
    }
    func apply(_ conf: inout Configuration?, status: Status) {
      let container = AttributeContainer([
        .font: font(status) as Any,
        .foregroundColor: color(status)?.turn(status.high && autohigh) as Any,
      ])
      conf?.attributedTitle = AttributedString(str(status) ?? "", attributes: container)
      if let spacing = spacing?(status) {
        conf?.titlePadding = spacing
      }
      if let alignment = alignment?(status) {
        conf?.titleAlignment = alignment
      }
    }
  }
  public var title: Title? {
    didSet { setNeedsStyle() }
  }

  public struct Subtitle {
    public var str: (Status) -> String?
    public var font: (Status) -> UIFont?
    public var color: (Status) -> UIColor?
    public var autohigh = false
    public init(str: @escaping (Status) -> String?,
                font: @escaping (Status) -> UIFont?,
                color: @escaping (Status) -> UIColor?,
                autohigh: Bool = false
    ) {
      self.str = str
      self.font = font
      self.color = color
      self.autohigh = autohigh
    }
    func apply(_ conf: inout Configuration?, status: Status) {
      let container = AttributeContainer([
        .font: font(status) as Any,
        .foregroundColor: color(status)?.turn(status.high && autohigh) as Any,
      ])
      conf?.attributedSubtitle = AttributedString(str(status) ?? "", attributes: container)
    }
  }
  public var subtitle: Subtitle? {
    didSet { setNeedsStyle() }
  }

  // backgroundInsets
  public struct Background {
    public var color: ((Status) -> UIColor?)?
    public var image: ((Status) -> (UIImage?, UIEdgeInsets?))?
    public var cornerRadius: ((Status) -> Double?)?
    public var borderWidth: ((Status) -> Double?)?
    public var borderColor: ((Status) -> UIColor?)?
    public var autohigh = false
    public init(color: ((Status) -> UIColor?)? = nil,
                image: ((Status) -> (UIImage?, UIEdgeInsets?))? = nil,
                cornerRadius: ((Status) -> Double?)? = nil,
                borderWidth: ((Status) -> Double?)? = nil,
                borderColor: ((Status) -> UIColor?)? = nil,
                autohigh: Bool = false
    ) {
      self.color = color
      self.image = image
      self.cornerRadius = cornerRadius
      self.borderWidth = borderWidth
      self.borderColor = borderColor
      self.autohigh = autohigh
    }
    func apply(_ conf: inout Configuration?, status: Status) {
      // baseBackgroundColor
      if let color = color?(status) {
        conf?.background.backgroundColor = color.turn(status.high && autohigh)
      }
      if let image = image?(status) {
        conf?.background.image = image.0?.turn(status.high && autohigh, image.1)
      }
      if let cornerRadius = cornerRadius?(status) {
        conf?.background.cornerRadius = cornerRadius
      }
      if let borderWidth = borderWidth?(status) {
        conf?.background.strokeWidth = borderWidth
      }
      if let borderColor = borderColor?(status) {
        conf?.background.strokeColor = borderColor
      }
    }
  }
  public var background: Background? {
    didSet { setNeedsStyle() }
  }

  public var buttonSize: UIButton.Configuration.Size? {
    didSet { setNeedsStyle() }
  }
  public var contentInsets: NSDirectionalEdgeInsets? {
    didSet { setNeedsStyle() }
  }
  public var cornerStyle: Configuration.CornerStyle? {
    didSet { setNeedsStyle() }
  }
  public var showsActivityIndicator: Bool? {
    didSet { setNeedsStyle() }
  }

  @objc func style() {
    configurationUpdateHandler = {
      guard let btn = $0 as? StyButton else { return }
      var conf = $0.configuration
      let status = Status($0.state)
      btn.image?.apply(&conf, status: status)
      btn.title?.apply(&conf, status: status)
      btn.subtitle?.apply(&conf, status: status)
      btn.background?.apply(&conf, status: status)
      if let size = btn.buttonSize {
        conf?.buttonSize = size
      }
      if let insets = btn.contentInsets {
        conf?.contentInsets = insets
      }
      if let style = btn.cornerStyle {
        conf?.cornerStyle = style
      }
      if let shows = btn.showsActivityIndicator {
        conf?.showsActivityIndicator = shows
      }
      $0.configuration = conf
    }
  }
  func setNeedsStyle() {
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(style), object: nil)
    perform(#selector(style), with: nil, afterDelay: 0)
  }

  deinit { print("sty button, deinit") }
}

extension UIColor {
  fileprivate func turn(_ flag: Bool) -> UIColor {
    flag ? withAlphaComponent(0.75) : self
  }
}
extension UIImage {
  fileprivate func turn(_ flag: Bool, _ insets: UIEdgeInsets?) -> UIImage {
    (flag ? brighted(0.05) : self).inset(insets)
  }
}

extension UIImage {
  // -1: black, 1: white
  fileprivate func brighted(_ val: Double) -> UIImage {
    let filter = CIFilter.colorControls()
    filter.inputImage = CIImage(image: self)
    filter.brightness = Float(val)
    if let ciimg = filter.outputImage,
       let cgimg = CIContext(options: nil).createCGImage(ciimg, from: ciimg.extent)
    {
      let img = UIImage(cgImage: cgimg, scale: scale, orientation: .up)
      return img
    }
    return self
  }
  fileprivate func inset(_ insets: UIEdgeInsets?) -> UIImage {
    if let insets {
      return resizableImage(withCapInsets: insets, resizingMode: .stretch)
    } else {
      return self
    }
  }
}

extension UIControl.State {
  fileprivate var name: String {
    switch self {
    case .normal: "normal"              // 0
    case .highlighted: "highlighted"    // 1
    case .disabled: "disabled"          // 2
    case .selected: "selected"          // 4
    case .focused: "focused"            // 8
    case .application: "application"    // 16711680
    case .reserved: "reserved"          // 4278190080
    default: "unknown \(rawValue)"
    }
  }
}
