//
//  UIScrollView+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 4/25/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import UIKit
import Common

public extension UIScrollView {
	var isScrolledToEnd: Bool {
		let bottomEdge = contentOffset.y + bounds.size.height - contentInset.bottom
		let isAtEnd = bottomEdge >= contentSize.height
		return isAtEnd
	}
	
	func scrollToEnd(animated: Bool) {
		let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
		setContentOffset(bottomOffset, animated: animated)
	}
}
