//
//  UITabBarController+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 12/31/18.
//  Copyright © 2018 Noah Emmet. All rights reserved.
//

import Foundation
import UIKit
import Common

public extension UITabBarController {
  var orderedTabBarItemViews: [UIView] {
    let interactionViews = tabBar.subviews.filter({$0.isUserInteractionEnabled})
    return interactionViews.sorted(by: {$0.frame.minX < $1.frame.minX})
  }
}
