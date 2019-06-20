//
//  UITouch+Extensions.swift
//  FingerPaint
//
//  Created by Noah Emmet on 5/28/17.
//  Copyright © 2017 Sticks. All rights reserved.
//

import Foundation
import Common

public extension UITouch {
	var address: String {
		return String(format: "%p", self)
	}
}

public extension TouchPoint {
	init(_ uiTouch: UITouch) {
		let center = uiTouch.location(in: uiTouch.view)
        self.init(center)
	}
}
