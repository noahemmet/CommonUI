//
//  DimView.swift
//
//  Created by Noah Emmet on 12/15/16.
//  Copyright © 2016 Sticks. All rights reserved.
//

import UIKit

public class DimView: UIView {
  public var onTap: (_: (DimView) -> Void)?
  
  public var cutoutFrame: CGRect? {
    didSet {
      if let cutoutFrame = cutoutFrame {
        self.mask(rect: cutoutFrame, cornerRadius: Layout.cornerRadiusMedium, invert: true)
      } else {
        self.layer.mask = nil
      }
      setNeedsLayout()
      layoutIfNeeded()
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    backgroundColor = UIColor(white: 0.0, alpha: 0.4) // mimic the default dimmingviews as close as possible
    
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(handleTap(_:))
    )
    tapGestureRecognizer.cancelsTouchesInView = false
    addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc
  private func handleTap(_: UITapGestureRecognizer) {
    onTap?(self)
  }
  
  public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    if cutoutFrame?.contains(point) == true {
      // Tapped within the mask
      return false
    }
    // Tapped outside the mask
    return true
  }
}
