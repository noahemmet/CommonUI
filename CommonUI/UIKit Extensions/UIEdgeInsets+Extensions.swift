//
//  UIEdgeInsets+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 7/24/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public extension UIEdgeInsets {
    
    init(dimension: CGFloat) {
        self.init(top: dimension, left: dimension, bottom: dimension, right: dimension)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    /// Replaces given values
    func replacing(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> UIEdgeInsets {
        return UIEdgeInsets(top: top ?? self.top, left: left ?? self.left, bottom: bottom ?? self.bottom, right: right ?? self.right)
    }
    
    var inverted: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}
