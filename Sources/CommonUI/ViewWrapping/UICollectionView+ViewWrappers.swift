//
//  UICollectionView+ViewWrapping.swift
//  CommonUI
//
//  Created by Noah Emmet on 8/7/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UICollectionViewCell

/// Wraps a UIView inside of a CollectionViewCell, for easy reuse between collection views and table views.
open class WrapperCollectionCell<View: UIView>: UICollectionViewCell, ViewWrapping, ViewModelConfigurable where View: ViewModelConfigurable {
  public class func wrapping(view: View) -> WrapperCollectionCell<View>? {
    let contentView = view.superview
    return contentView?.superview as? WrapperCollectionCell<View>
  }
  
  private let viewWrapper: ViewWrapper<View>
  
  public let wrappedView: View = {
    return View.fromXibOrFile()
  }()
  
  public override init(frame: CGRect) {
    viewWrapper = .init(around: wrappedView)
    super.init(frame: frame)
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    viewWrapper = .init(around: wrappedView)
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    contentView.addSubview(viewWrapper)
    viewWrapper.activateConstraints(to: contentView)
    wrappedView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
  }
  
  public var isSelectable: Bool { 
    get { return viewWrapper.isSelectable }
    set { viewWrapper.isSelectable = isSelectable }
  }
  
  open override var isSelected: Bool {
    didSet { viewWrapper.isSelected = isSelected }
  }
  
  open override var isHighlighted: Bool {
    didSet { viewWrapper.isHighlighted = isHighlighted }
  }
  
  public var highlightColor: UIColor {
    set { viewWrapper.animator.highlightColor = highlightColor }
    get { return viewWrapper.animator.highlightColor }
  }
  
  public var nonHighlightColor: UIColor { 
    set { viewWrapper.animator.nonHighlightColor = nonHighlightColor }
    get { return viewWrapper.animator.nonHighlightColor }
  }
  
  public var preferredWidth: CGFloat? {
    get { return viewWrapper.preferredWidth}
    set { viewWrapper.preferredWidth = preferredWidth }
  }
  
  open override var intrinsicContentSize: CGSize {
    return wrappedView.intrinsicContentSize
  }
}

// MARK: - UICollectionReusableView

/// Wraps a UIView inside of a UICollectionReusableView, for easy reuse between collection views and table views.
open class WrapperCollectionReusableView<View: UIView>: UICollectionReusableView, ViewWrapping, ViewModelConfigurable where View: ViewModelConfigurable {
  private let viewWrapper: ViewWrapper<View>
  
  public let wrappedView: View = {
    return View.fromXibOrFile()
  }()
  
  public override init(frame: CGRect) {
    viewWrapper = .init(around: wrappedView)
    super.init(frame: frame)
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    viewWrapper = .init(around: wrappedView)
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    addSubview(viewWrapper)
    viewWrapper.translatesAutoresizingMaskIntoConstraints = false
    viewWrapper.activateConstraints(to: self)
    viewWrapper.preservesSuperviewLayoutMargins = true
    preservesSuperviewLayoutMargins = true
  }
  
  public var highlightColor: UIColor {
    set { viewWrapper.animator.highlightColor = highlightColor }
    get { return viewWrapper.animator.highlightColor }
  }
  
  public var nonHighlightColor: UIColor { 
    set { viewWrapper.animator.nonHighlightColor = nonHighlightColor }
    get { return viewWrapper.animator.nonHighlightColor }
  }
}
