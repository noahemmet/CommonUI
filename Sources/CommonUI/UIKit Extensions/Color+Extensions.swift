//
//  Color+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 5/25/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import Common

extension Color {
	public init(_ uiColor: UIColor) {
		var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
		uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
	}
	
	public var uiColor: UIColor {
		let r = CGFloat(red)
		let g = CGFloat(green)
		let b = CGFloat(blue)
		let a = CGFloat(alpha)
		return UIColor(red: r, green: g, blue: b, alpha: a)
	}
	
	public var cgColor: CGColor {
		return uiColor.cgColor
	}

}
