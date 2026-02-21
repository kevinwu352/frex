//
//  UIScrollView_Refresh.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/21/26.
//

import Combine
import MJRefresh
import UIKit

class RefreshHeader: MJRefreshGifHeader {
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
      setup()
    }
  }
  func setup() {
    backgroundColor = .clear
    let images = [
      UIImage(resource: .refreshSpinner01),
      UIImage(resource: .refreshSpinner02),
      UIImage(resource: .refreshSpinner03),
      UIImage(resource: .refreshSpinner04),
      UIImage(resource: .refreshSpinner05),
      UIImage(resource: .refreshSpinner06),
      UIImage(resource: .refreshSpinner07),
      UIImage(resource: .refreshSpinner08),
      UIImage(resource: .refreshSpinner09),
      UIImage(resource: .refreshSpinner10),
      UIImage(resource: .refreshSpinner11),
      UIImage(resource: .refreshSpinner12),
    ]
    setImages(images, duration: 1, for: .idle)
    setImages(images, duration: 1, for: .pulling)
    setImages(images, duration: 1, for: .refreshing)
    lastUpdatedTimeLabel?.isHidden = true
    stateLabel?.isHidden = true
    mj_h = 54
  }
}

private nonisolated(unsafe) var kHeadHandlerKey = 0
private nonisolated(unsafe) var kHeadPublisherKey = 0

extension UIScrollView {

  public var headHandler: (() -> Void)? {
    get { objc_getAssociatedObject(self, &kHeadHandlerKey) as? () -> Void }
    set { objc_setAssociatedObject(self, &kHeadHandlerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
  }

  public var headPublisher: PassthroughSubject<Void, Never> {
    if let pub = objc_getAssociatedObject(self, &kHeadPublisherKey) as? PassthroughSubject<Void, Never> {
      return pub
    } else {
      let pub = PassthroughSubject<Void, Never>()
      objc_setAssociatedObject(self, &kHeadPublisherKey, pub, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return pub
    }
  }

  public func headReset(show: Bool) {
    if show {
      let view: RefreshHeader
      if let header = mj_header as? RefreshHeader {
        view = header
      } else {
        view = RefreshHeader()
        mj_header = view
      }
      view.setup()
      view.refreshingBlock = { [weak self] in
        guard let self else { return }
        self.headHandler?()
        (objc_getAssociatedObject(self, &kHeadPublisherKey) as? PassthroughSubject<Void, Never>)?.send()
      }
      view.endRefreshing()
    } else {
      if let header = mj_header {
        if header.isRefreshing {
          header.endRefreshing { [weak self] in self?.mj_header = nil }
        } else {
          mj_header = nil
        }
      }
    }
  }

  public func headBeginRefreshing() {
    // will trigger handler
    mj_header?.beginRefreshing()
  }

  public func headEndRefreshing() {
    mj_header?.endRefreshing()
  }

}

class RefreshFooter: MJRefreshAutoNormalFooter {
  func setup() {
    backgroundColor = .clear
    setTitle(String(localized: "refresh_foot_idle", bundle: .module), for: .idle)
    setTitle(String(localized: "refresh_foot_refreshing", bundle: .module), for: .refreshing)
    setTitle(String(localized: "refresh_foot_nomore", bundle: .module), for: .noMoreData)
    stateLabel?.font = UIFont.systemFont(ofSize: 14)
    stateLabel?.textColor = UIColor(resource: .refreshFootTitle)
    loadingView?.color = UIColor(resource: .refreshFootIndicator)
    mj_h = 44
  }
}

private nonisolated(unsafe) var kFootHandlerKey = 0
private nonisolated(unsafe) var kFootPublisherKey = 0

extension UIScrollView {

  public var footHandler: (() -> Void)? {
    get { objc_getAssociatedObject(self, &kFootHandlerKey) as? () -> Void }
    set { objc_setAssociatedObject(self, &kFootHandlerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
  }

  public var footPublisher: PassthroughSubject<Void, Never> {
    if let pub = objc_getAssociatedObject(self, &kFootPublisherKey) as? PassthroughSubject<Void, Never> {
      return pub
    } else {
      let pub = PassthroughSubject<Void, Never>()
      objc_setAssociatedObject(self, &kFootPublisherKey, pub, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return pub
    }
  }

  public func footReset(show: Bool, more: Bool) {
    if show {
      let view: RefreshFooter
      if let footer = mj_footer as? RefreshFooter {
        view = footer
      } else {
        view = RefreshFooter()
        mj_footer = view
      }
      view.setup()
      view.refreshingBlock = { [weak self] in
        guard let self else { return }
        self.footHandler?()
        (objc_getAssociatedObject(self, &kFootPublisherKey) as? PassthroughSubject<Void, Never>)?.send()
      }
      if more {
        view.endRefreshing()
        view.resetNoMoreData()
      } else {
        view.endRefreshingWithNoMoreData()
      }
    } else {
      if let footer = mj_footer {
        if footer.isRefreshing {
          footer.endRefreshing { [weak self] in self?.mj_footer = nil }
        } else {
          mj_footer = nil
        }
      }
    }
  }

}
