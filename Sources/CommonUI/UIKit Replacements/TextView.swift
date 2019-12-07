//
//  TextView.swift
//  Slash
//
//  Created by Noah Emmet on 4/7/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit
import Common

@IBDesignable
open class TextView: UITextView, ViewModelConfigurable {
  public let placeholderLabel: UILabel = UILabel()
  
//    private var placeholderLabelConstraints = [NSLayoutConstraint]()
  private var placeholderConstraints: AnchorConstraints!
  
  @IBInspectable open var maxHeight: CGFloat = 0 {
    didSet {
      textDidChange()
    }
  }
  
  @IBInspectable open var placeholder: String? = nil {
    didSet {
      placeholderLabel.text = placeholder
    }
  }
  
  @IBInspectable open var placeholderColor: UIColor = .secondaryLabel {
    didSet {
      placeholderLabel.textColor = placeholderColor
    }
  }
  
  open override var font: UIFont! {
    didSet {
      if placeholderFont == nil {
        placeholderLabel.font = font
      }
    }
  }
  
  open var placeholderFont: UIFont? {
    didSet {
      let font = (placeholderFont != nil) ? placeholderFont : self.font
      placeholderLabel.font = font
    }
  }
  
  open override var textAlignment: NSTextAlignment {
    didSet {
      placeholderLabel.textAlignment = textAlignment
    }
  }
  
  open override var text: String! {
    didSet {
      textDidChange()
    }
  }
  
  open override var attributedText: NSAttributedString! {
    didSet {
      textDidChange()
    }
  }
  
  @IBInspectable
  open override var textContainerInset: UIEdgeInsets {
    didSet {
      updateConstraintsForPlaceholderLabel()
    }
  }
  
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textDidChange),
                                           name: UITextView.textDidChangeNotification,
                                           object: nil)
    // removes padding
    textContainer.lineFragmentPadding = 0
    
    placeholderLabel.font = font
    placeholderLabel.textColor = placeholderColor
    placeholderLabel.textAlignment = textAlignment
    placeholderLabel.text = placeholder
    placeholderLabel.numberOfLines = 0
    placeholderLabel.backgroundColor = UIColor.clear
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(placeholderLabel)
    placeholderConstraints = placeholderLabel.activateConstraints(to: self)
    placeholderLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    placeholderLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    placeholderLabel.setContentHuggingPriority(.required, for: .vertical)
    placeholderLabel.setContentHuggingPriority(.required, for: .horizontal)
    heightAnchor.constraint(greaterThanOrEqualTo: placeholderLabel.heightAnchor).isActive = true
    updateConstraintsForPlaceholderLabel()
  }
  
  private func updateConstraintsForPlaceholderLabel() {
    placeholderConstraints.top.constant = textContainerInset.top
    placeholderConstraints.bottom.constant = textContainerInset.bottom
    placeholderConstraints.leading.constant = textContainerInset.left
    placeholderConstraints.trailing.constant = textContainerInset.right
  }
  
  @objc private func textDidChange() {
    placeholderLabel.isHidden = !text.isEmpty
    setNeedsDisplay()
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
  }
  
  public func configure(with string: String) {
    text = string
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: UITextView.textDidChangeNotification,
                                              object: nil)
  }
}
