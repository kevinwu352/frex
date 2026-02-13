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

  // imageReservation
  public struct Icon {
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
  }
  public var image: Icon? {
    didSet { setNeedsStyle() }
  }

  // titleLineBreakMode
  // subtitleLineBreakMode
  public struct Text {
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
  }
  public var title: Text? {
    didSet { setNeedsStyle() }
  }
  public var subtitle: Text? {
    didSet { setNeedsStyle() }
  }

  // backgroundInsets
  public struct Background {
    public var color: ((Status) -> UIColor?)?
    public var image: ((Status) -> (UIImage?, UIEdgeInsets?))?
    public var cornerRadius: ((Status) -> Double?)?
    public var cornerStyle: ((Status) -> Configuration.CornerStyle?)?
    public var borderWidth: ((Status) -> Double?)?
    public var borderColor: ((Status) -> UIColor?)?
    public var autohigh = false
    public init(color: ((Status) -> UIColor?)? = nil,
                image: ((Status) -> (UIImage?, UIEdgeInsets?))? = nil,
                cornerRadius: ((Status) -> Double?)? = nil,
                cornerStyle: ((Status) -> Configuration.CornerStyle?)? = nil,
                borderWidth: ((Status) -> Double?)? = nil,
                borderColor: ((Status) -> UIColor?)? = nil,
                autohigh: Bool = false
    ) {
      self.color = color
      self.image = image
      self.cornerRadius = cornerRadius
      self.cornerStyle = cornerStyle
      self.borderWidth = borderWidth
      self.borderColor = borderColor
      self.autohigh = autohigh
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

  public var showsActivityIndicator: Bool? {
    didSet { setNeedsStyle() }
  }

  @objc func style() {
    configurationUpdateHandler = {
      guard let btn = $0 as? StyButton else { return }
      var conf = $0.configuration
      let status = Status($0.state)
      if let image = btn.image {
        let img = image.image(status)
        if image.autohigh {
          if img.1 != nil {
            print("111")
            conf?.image = img.0
            conf?.baseForegroundColor = img.1?.turn(status.high)
          } else {
            print("222")
            conf?.image = img.0?.turn(status.high, nil)
          }
        } else {
          print("333")
          conf?.image = img.0
          conf?.baseForegroundColor = img.1
        }
      }
      $0.configuration = conf
    }
  }
  func setNeedsStyle() {
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(style), object: nil)
    perform(#selector(style), with: nil, afterDelay: 0)
  }
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
    if let insets = insets {
      return resizableImage(withCapInsets: insets, resizingMode: .stretch)
    } else {
      return self
    }
  }
}

extension UIControl.State {
  fileprivate var name: String {
    switch self {
    case .normal: "normal"               // 0
    case .highlighted: "highlighted"     // 1
    case .disabled: "disabled"           // 2
    case .selected: "selected"           // 4
    case .focused: "focused"             // 8
    case .application: "application"     // 16711680
    case .reserved: "reserved"           // 4278190080
    default: "unknown \(rawValue)"
    }
  }
}
