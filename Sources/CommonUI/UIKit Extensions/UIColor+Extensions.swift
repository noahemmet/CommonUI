//
//  UIColor+Extensions.swift
//  Scroll
//
//  Created by Noah Emmet on 1/29/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit
import UIKit
import Common

public extension UIColor {
	
	func lighter(by percentage: CGFloat = 30.0) -> UIColor {
		return self.adjust(by: abs(percentage))!
	}
	
	func darker(by percentage: CGFloat = 30.0) -> UIColor {
		return self.adjust(by: -1 * abs(percentage))!
	}
	
	func adjust(by percentage: CGFloat) -> UIColor! {
		var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0;
		if (self.getRed(&r, green: &g, blue: &b, alpha: &a)) {
			return UIColor(red: min(r + percentage/100, 1.0),
						   green: min(g + percentage/100, 1.0),
						   blue: min(b + percentage/100, 1.0),
						   alpha: a)
		} else {
			return nil
		}
	}
	
	var inverse: UIColor {
		var alpha: CGFloat = 1.0
		
		var white: CGFloat = 0.0
		if self.getWhite(&white, alpha: &alpha) {
			return UIColor(white: 1.0 - white, alpha: alpha)
		}
		
		var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
		if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
		}
		
		var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
		}
		
		return self
	}

    
    func shuffled(within maxPercentage: CGFloat) -> UIColor! {
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0;
        if (self.getRed(&r, green: &g, blue: &b, alpha: &a)) {
            let rSign: CGFloat = Bool.random() ? 1 : -1
            let rPercentage: CGFloat = CGFloat.random(in: 0..<maxPercentage) * rSign
            let gSign: CGFloat = Bool.random() ? 1 : -1
            let gPercentage: CGFloat = CGFloat.random(in: 0..<maxPercentage) * gSign
            let bSign: CGFloat = Bool.random() ? 1 : -1
            let bPercentage: CGFloat = CGFloat.random(in: 0..<maxPercentage) * bSign
            let red = min(r + rPercentage/100, 1.0)
            let green = min(g + gPercentage/100, 1.0)
            let blue = min(b + bPercentage/100, 1.0)
            return UIColor(red: red,
                           green: green,
                           blue: blue,
                           alpha: a)
        } else {
            return nil
        }
    }
}

public extension UIColor {
	
	var color: Color {
		return Color(self)
	}
	
	var hexValue: String {
		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0
		
		getRed(&r, green: &g, blue: &b, alpha: &a)
		
		let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
		
		return String(format:"#%06x", rgb)
	}
}
