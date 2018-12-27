//
//  UIStackView+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 7/2/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public extension UIStackView {
    func setArrangedSubviews(_ subviews: [UIView]) {
        removeAllArrangedSubviews()
        for view in subviews {
            addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
