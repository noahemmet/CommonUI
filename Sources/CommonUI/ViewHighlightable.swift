//
//  ViewHighlightable.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/22/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewHighlightable {
    var highlightColor: UIColor { get }
    var nonHighlightColor: UIColor { get }
    var highlightableViews: [UIView] { get }
    var highlightableScalableView: UIView { get }
}

public extension ViewHighlightable {
	var highlightColor: UIColor { return AppStyle.highlight }
	var nonHighlightColor: UIColor { return AppStyle.background }
}

//extension UIView: ViewHighlightable {
//    public func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        UIView.animate(withDuration: animated ? Animation.defaultDuration : 0) { 
//            self.backgroundColor = highlighted ? self.highlightColor : self.nonHighlightColor
//        }
//    }
//}
