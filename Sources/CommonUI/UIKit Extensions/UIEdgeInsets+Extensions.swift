//
//  UIEdgeInsets+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 7/24/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public extension UIEdgeInsets {
    
    init(dimension: CGFloat) {
        self.init(top: dimension, left: dimension, bottom: -dimension, right: -dimension)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
    }
	
	init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
		self.init(top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0)
	}
    
    /// Replaces given values
    func replacing(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> UIEdgeInsets {
        return UIEdgeInsets(top: top ?? self.top, left: left ?? self.left, bottom: bottom ?? self.bottom, right: right ?? self.right)
    }
    
    var inverted: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
	
	var horizontal: (left: CGFloat, right: CGFloat) {
		get {
			return (left: left, right: right)
		}
		set {
			left = newValue.left
			right = newValue.right
		}
	}
	
	var vertical: (top: CGFloat, bottom: CGFloat) {
		get {
			return (top: top, bottom: bottom)
		}
		set {
			top = newValue.top
			bottom = newValue.bottom
		}
	}
}
