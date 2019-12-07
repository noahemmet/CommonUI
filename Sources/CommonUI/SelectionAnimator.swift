//
//  SelectionAnimator.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/23/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public struct SelectionAnimator {
  public var scalingView: UIView
  public var highlightableViews: [UIView]
  public var containerView: UIView
  
  public var highlightColor: UIColor {
    didSet { setHighlighted(false, animated: false) }
  }
  
  public var nonHighlightColor: UIColor {
    didSet { setHighlighted(false, animated: false) }
  }
  
  public init(view: UIView & ViewHighlightable, containerView: UIView) {
    self.scalingView = view.highlightableScalableView
    self.highlightableViews = view.highlightableViews
    self.containerView = containerView
    self.highlightColor = view.highlightColor
    self.nonHighlightColor = view.nonHighlightColor
  }
  
  public init(
    scalingView: UIView,
    highlightableView: UIView,
    containerView: UIView,
    highlightColor: UIColor,
    nonHighlightColor: UIColor
  ) {
    self.scalingView = scalingView
    self.highlightableViews = [highlightableView]
    self.containerView = containerView
    self.highlightColor = highlightColor
    self.nonHighlightColor = nonHighlightColor
  }
  
  static let defaultDuration: TimeInterval = Animation.defaultDuration
  static let inDampingRatio: CGFloat = 0.9
  static let inTransform: CGAffineTransform = .init(scaleX: 0.9, y: 0.9) 
  private let animator = UIViewPropertyAnimator(
    duration: SelectionAnimator.defaultDuration, 
    dampingRatio: SelectionAnimator.inDampingRatio, 
    animations: nil
  )
  
  private func color(highlighted: Bool) -> UIColor {
    return highlighted ? highlightColor : nonHighlightColor
  }
  
  private func setColor(_ color: UIColor) {
    for view in self.highlightableViews {
//            view.backgroundColor = color
      view.layer.backgroundColor = color.cgColor
    }
    self.scalingView.backgroundColor = color
    self.containerView.backgroundColor = color
  }
  
  public func setSelected(_ selected: Bool, animated: Bool) {
//        print("s: \(selected), a: \(animated)")
    animator.addAnimations {
      self.scalingView.transform = selected ? SelectionAnimator.inTransform : CGAffineTransform.identity
    }
    let delay: TimeInterval = 0// selected ? 0 : 0.25
    animator.startAnimation(afterDelay: delay)
  }
  
  public func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        print("h: \(highlighted), a: \(animated)")
    animator.addAnimations {
      let color = self.color(highlighted: highlighted)
      self.setColor(color)
    }
    let delay: TimeInterval = 0 // highlighted ? 0 : 0.25
    animator.startAnimation(afterDelay: delay)
  }
}
