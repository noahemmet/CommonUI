//
//  UIView+Extensions.swift
//  Slash
//
//  Created by Noah Emmet on 4/7/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit
import UIKit

public protocol XibViewInstantiatable: class {
    static func fromXib() -> Self
}

extension UIView: XibViewInstantiatable {
    public static var xibIdentifier: String {
        // Get the name of current class
        let classString = NSStringFromClass(self)
        let components = classString.components(separatedBy: ".")
        assert(components.count > 0, "Failed extract class name from \(classString)")
        return components.last!
    }
}

extension XibViewInstantiatable where Self: UIView {
    
    public static func fromXib() -> Self {
        let nib = UINib(nibName: xibIdentifier, bundle: nil)
        return self.instantiateFromXib(nib, type: self)
    }
    
    public static func fromXibOrFile() -> Self {
        let bundle = Bundle(for: self)
        let nibExists = bundle.path(forResource: String(describing: self), ofType: "nib") != nil
        if nibExists {
            let nib = UINib(nibName: self.xibIdentifier, bundle: bundle)
            let nibViews = nib.instantiate(withOwner: self, options: nil)
            return nibViews.first as! Self
        } else {
            return self.init(frame: .zero)
        }
    }
}

extension UIView {
    fileprivate class func instantiateFromXib<View: UIView>(_ xib: UINib, type: View.Type) -> View {
        return xib.instantiate(withOwner: nil, options: nil).first as! View
    }
}

// MARK: - UI

extension UIView {
	@objc
	open func setBackgroundColors(to backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        for subview in subviews {
            subview.setBackgroundColors(to: backgroundColor)
        }
	}
	
	public var findFirstResponder: UIResponder? {
		if self.isFirstResponder {
			return self
		}
		let firstResponder = subviews.first { $0.findFirstResponder }
		return firstResponder
	}
	
	func mask(rect maskRect: CGRect, invert: Bool = false) {
		let maskLayer = CAShapeLayer()
		let path = CGMutablePath()
		if invert {
			path.addRect(bounds)
		}
		path.addRect(maskRect)
		
		maskLayer.path = path
		if (invert) {
			maskLayer.fillRule = .evenOdd
		}
		layer.mask = maskLayer
	}

}

// MARK: - Constraints

extension UIView {
    public func useAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func constraint(named identifier: String) -> NSLayoutConstraint? {
        return self.constraints.filter { $0.identifier == identifier }.first
    }
}
