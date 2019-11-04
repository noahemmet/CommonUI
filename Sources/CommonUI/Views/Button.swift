//
//  Button.swift
//  Views
//
//  Created by Noah Emmet on 5/27/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public class Button: UIButton {
  
  public let spinner = UIActivityIndicatorView(frame: .zero)
  public private(set) var isProcessing: Bool = false {
    didSet {
      self.isUserInteractionEnabled = !isProcessing
    }
  }
  public var onTap: (() -> Void)?
  
  public convenience init(highlightColor: UIColor, nonHighlightColor: UIColor) {
    self.init(frame: .zero)
    self.highlightColor = highlightColor
    self.nonHighlightColor = nonHighlightColor
    commonInit()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    layer.cornerRadius = 6
    
    setTitleColor(UIColor.label.inverse, for: .normal)
    setTitleColor(UIColor.secondaryLabel.inverse, for: .normal)
    
    titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
    
    spinner.color = UIColor.label.inverse
    
    addSubview(spinner)
    let spinnerConstraints = spinner.constraints(toMarginsOf: self)
    NSLayoutConstraint.activate([
      spinnerConstraints.top,
      spinnerConstraints.bottom,
      spinnerConstraints.trailing,
    ])
    
    // You can use a target or a closure for taps.
    self.addTarget(self, action: #selector(handleTap), for: .primaryActionTriggered)
  }
  
  public override func didMoveToSuperview() {
    super.didMoveToSuperview()
    // needs to happen after `init`
    isHighlighted = false
  }
  
  public func setProcessing(_ isProcessing: Bool, animated: Bool) {
    self.isProcessing = isProcessing
    UIView.transition(with: self, duration: Animation.shortDuration, options: [], animations: {
      if isProcessing {
        self.spinner.alpha = 1
        self.spinner.startAnimating()
      } else {
        self.spinner.alpha = 0
      }
    }, completion: nil)
  }
  
  open var highlightColor: UIColor = AppStyle.tintHighlight {
    didSet { isHighlighted = false }
  }
  open var nonHighlightColor: UIColor = AppStyle.tint {
    didSet { isHighlighted = false }
  }
  
  override open var isHighlighted: Bool {
    didSet {
      UIView.transition(with: self, duration: Animation.shortDuration, options: [], animations: {
        self.backgroundColor = self.isHighlighted ? self.highlightColor : self.nonHighlightColor
      }, completion: nil)
    }
  }
  
  @objc
  private func handleTap() {
    onTap?()
  }
  
  public override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    let newSize = CGSize(width: size.width + titleEdgeInsets.left + titleEdgeInsets.right,
                         height: size.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
    return size
  }
}
