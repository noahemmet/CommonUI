//
//  NSAttributedString+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 11/14/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    func append(_ string: String, attributes: [NSAttributedString.Key: Any] = [:]) {
        let attributed = NSAttributedString(string: string, attributes: attributes)
        append(attributed)
    }
}

public extension String {
	func attributed(font: UIFont = .preferredFont(forTextStyle: .body)) -> NSAttributedString {
		return NSAttributedString(string: self, attributes: [.font: font])
	}
}
