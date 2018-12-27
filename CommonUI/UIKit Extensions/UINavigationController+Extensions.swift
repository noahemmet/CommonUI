//
//  UINavigationController+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 11/16/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public extension UINavigationController {
    func pushNewStack(startingWith viewController: UIViewController, animated: Bool) {
        let rootViewController = viewControllers[0]
        setViewControllers([rootViewController, viewController], animated: animated)
    }
}
