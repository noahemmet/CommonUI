//
//  CALayer+Extensions.swift
//  Views
//
//  Created by Noah Emmet on 5/17/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
  public func image(withSize size: CGSize, backgroundColor: CGColor?) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, 0.0)
    defer { UIGraphicsEndImageContext() }
    if let context = UIGraphicsGetCurrentContext() {
      let fillColor = backgroundColor ?? UIColor.clear.cgColor
      context.setFillColor(fillColor)
      context.fill(CGRect(origin: .zero, size: size))
      render(in: context)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      return image
    }
    return nil
  }
}

// MARK: - Drawing

extension CAShapeLayer {
  public func drawDashedBorder(insetBy inset: UIEdgeInsets = .zero, color: UIColor, width borderWidth: CGFloat = 4, corner: CGFloat = 4, pattern: [CGFloat] = [4, 1]) {
    fillColor = UIColor.clear.cgColor
    strokeColor = color.cgColor
    cornerRadius = corner
    lineWidth = borderWidth
    lineJoin = .round
    lineDashPattern = pattern as [NSNumber]
    let path = CGMutablePath()
    // corners
    let borderInset = borderWidth / 2
    let leftTop = CGPoint(x: inset.left + borderInset, y: inset.top + borderInset)
    let rightTop = CGPoint(x: bounds.width - inset.right - borderInset, y: inset.top + borderInset)
    let rightBottom = CGPoint(x: bounds.width - inset.right - borderInset, y: bounds.height - inset.bottom)
    let leftBottom = CGPoint(x: inset.left + borderInset, y: bounds.height - inset.bottom - borderInset)
    path.move(to: leftTop)
    path.addLine(to: rightTop)
    path.addLine(to: rightBottom)
    path.addLine(to: leftBottom)
    path.addLine(to: leftTop) // and back
    self.path = path
  }
}
